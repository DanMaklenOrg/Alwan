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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entity_list_view.dart';
import 'entity_view.dart';
import 'project_list_view.dart';

class PikaDomainView extends StatefulWidget {
  const PikaDomainView({super.key});

  @override
  State<PikaDomainView> createState() => _PikaDomainViewState();
}

class _PikaDomainViewState extends State<PikaDomainView> {
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
            value: filterState.hideCompletedEntities,
            onChanged: (value) => setState(() => filterState.hideCompletedEntities = value ?? false),
          )),
      DropdownButton<String>(
        value: filterState.domainId,
        items: [
          const DropdownMenuItem<String>(value: null, child: Text('')),
          for (var d in container.domains) DropdownMenuItem<String>(value: d.id, child: Text(d.name)),
        ],
        onChanged: (val) => setState(() => filterState.domainId = val),
      ),
    ];
  }

  Row _buildMainView() {
    var container = context.read<PikaContainer>();
    var filterState = context.watch<PikaFilterState>();
    var userStats = context.watch<UserStats>();
    return Row(
      children: [
        Expanded(
          child: EntityListView(
            entities: filterState.filterEntity(container.entities.toResourceList(), userStats),
            selectedEntity: _selectedEntity,
            onSelection: (entity) => setState(() => _selectedEntity = entity),
          ),
        ),
        Expanded(child: _selectedEntity != null ? EntityView(entity: _selectedEntity!) : Container()),
        Expanded(child: ProjectListView(projects: filterState.filterProject(container.projects.toResourceList(), userStats))),
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
