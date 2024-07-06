import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/dto_converter.dart';
import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/resource_map.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
import 'package:alwan/ui/pika/pika_filter_state.dart';
import 'package:alwan/ui/pika/project_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'named_resource_list_view.dart';
import 'entity_view.dart';

class PikaDomainView extends StatefulWidget {
  const PikaDomainView({super.key});

  @override
  State<PikaDomainView> createState() => _PikaDomainViewState();
}

class _PikaDomainViewState extends State<PikaDomainView> {
  Project? _selectedProject;
  Entity? _selectedEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(child: _buildMainView()),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._filters(),
        const Spacer(),
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: _saveUserStats),
      ],
    );
  }

  List<Widget> _filters() {
    var container = context.read<PikaContainer>();
    var filterState = context.watch<PikaFilterState>();
    return [
      SizedBox(
          width: 175,
          child: CheckboxListTile(
            title: const Text("Hide Completed"),
            value: filterState.hideCompletedEntities.value,
            onChanged: (value) => setState(() => filterState.hideCompletedEntities.value = value ?? false),
          )),
      DropdownButton<String>(
        value: filterState.domainId.value,
        items: [
          const DropdownMenuItem<String>(value: null, child: Text('')),
          for (var d in container.domains) DropdownMenuItem<String>(value: d.id, child: Text(d.name)),
        ],
        onChanged: (val) => setState(() => filterState.domainId.value = val),
      ),
      DropdownButton<Tag>(
        value: filterState.tag.value,
        items: [
          const DropdownMenuItem<Tag>(value: null, child: Text('')),
          for (var t in container.tags.toResourceList()) DropdownMenuItem<Tag>(value: t, child: Text(t.name)),
        ],
        onChanged: (val) => setState(() => filterState.tag.value = val),
      ),
    ];
  }

  Row _buildMainView() {
    var container = context.read<PikaContainer>();
    var filterState = context.watch<PikaFilterState>();
    var userStats = context.watch<UserStats>();
    return Row(
      children: [
        Expanded(child: _buildProjectColumn(filterState.filterProject(container.projects.toResourceList(), userStats))),
        Expanded(
          child: NamedResourceListView<Entity>(
            resourceList: filterState.filterEntity(container.entities.toResourceList(), userStats),
            selectedResource: _selectedEntity,
            onSelection: (entity) => setState(() => _selectedEntity = entity),
          ),
        ),
        Expanded(child: _selectedEntity != null ? EntityView(entity: _selectedEntity!) : Container()),
      ],
    );
  }

  Widget _buildProjectColumn(List<Project> projects) {
    var list = NamedResourceListView<Project>(
      resourceList: projects,
      selectedResource: _selectedProject,
      onSelection: (project) => setState(() => _selectedProject = project),
    );
    if (_selectedProject == null) return list;
    return Column(
      children: [
        Expanded(child: list),
        Expanded(child: ProjectView(project: _selectedProject!)),
      ],
    );
  }

  Future _saveUserStats() async {
    var userStats = context.read<UserStats>();
    var converter = DtoConverter();
    var entityStats = userStats.getEntityStatList().map(converter.toEntityUserStatDto).toList();
    var projects = userStats.getCompletedProjectList().map((e) => e.fullyQualifiedId).toList();
    var dto = UserStatsDto(entityStats: entityStats, completedProjectIds: projects);
    await serviceProvider.get<ApiClient>().setUserStat(userStats.rootDomainId, dto);
  }
}
