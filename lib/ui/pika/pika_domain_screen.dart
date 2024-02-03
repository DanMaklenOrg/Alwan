import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/model_transformer.dart';
import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_context.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
import 'package:alwan/ui/pika/project_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entity_list_view.dart';
import 'entity_view.dart';

final class PikaDomainScreen extends StatefulWidget {
  const PikaDomainScreen({super.key, required this.domainId});

  final String domainId;

  @override
  State<PikaDomainScreen> createState() => _PikaDomainScreenState();
}

class _PikaDomainScreenState extends State<PikaDomainScreen> {
  Entity? _selectedEntity;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<PikaContext>(
      fetcher: _fetchData,
      builder: (context, state) => ChangeNotifierProvider.value(
        value: state,
        builder: (context, widget) => BaseScreenLayout(
          title: state.rootDomain.name,
          body: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildMainView(context)),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    var state = context.read<PikaContext>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: 175,
            child: CheckboxListTile(
              title: const Text("Hide Completed"),
              value: state.filterState.hideCompletedEntities,
              onChanged: (value) => setState(() => state.filterState.hideCompletedEntities = value ?? false),
            )),
        DropdownButton<String>(
          value: state.filterState.domainId,
          items: [
            const DropdownMenuItem<String>(value: null, child: Text('')),
            for (var d in state.getSubDomains()) DropdownMenuItem<String>(value: d.id, child: Text(d.name)),
          ],
          onChanged: (val) => setState(() => state.filterState.domainId = val),
        ),
        const Spacer(),
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: () => _saveUserStats(state)),
      ],
    );
  }

  Row _buildMainView(BuildContext context) {
    var pikaContext = context.watch<PikaContext>();
    return Row(
      children: [
        Expanded(
          child: EntityListView(
            entities: pikaContext.getEntities(),
            selectedEntity: _selectedEntity,
            onSelection: (entity) => setState(() => _selectedEntity = entity),
          ),
        ),
        Expanded(child: _selectedEntity != null ? EntityView(entity: _selectedEntity!) : Container()),
        Expanded(child: ProjectListView(projects: pikaContext.getProjects())),
      ],
    );
  }

  Future<PikaContext> _fetchData() async {
    var client = serviceProvider.get<ApiClient>();
    DomainDto baseDomainDto = await client.getDomain('_');
    DomainDto domainDto = await client.getDomain(widget.domainId);
    UserStatsDto userStatsDto = await client.getUserStat(widget.domainId);
    var transformer = ModelTransformer();
    return PikaContext(
      rootDomain: transformer.domainFromDto(domainDto),
      baseDomain: transformer.domainFromDto(baseDomainDto),
      userStats: transformer.fromUserStatsDto(userStatsDto),
    );
  }

  Future _saveUserStats(PikaContext state) async {
    var dto = ModelTransformer().toUserStatsDto(state.userStats);
    await serviceProvider.get<ApiClient>().setUserStat(state.rootDomain.id, dto);
  }
}
