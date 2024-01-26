import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_state.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
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
  Entity? selectedEntity;
  bool _hideCompletedEntities = false;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<PikaState>(
      fetcher: _fetchData,
      builder: (context, state) => ChangeNotifierProvider.value(
        value: state,
        builder: (context, widget) => BaseScreenLayout(
          title: state.domainName,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: 175,
            child: CheckboxListTile(
              title: const Text("Hide Completed"),
              value: _hideCompletedEntities,
              onChanged: (value) => setState(() => _hideCompletedEntities = value ?? false),
            )),
        // IconButton(onPressed: () => context.read<PikaState>().save(), icon: const Icon(Icons.save_outlined))
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: context.read<PikaState>().save()),
      ],
    );
  }

  Row _buildMainView(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EntityListView(
            entities: context.watch<PikaState>().getEntities(filterCompleted: _hideCompletedEntities),
            selectedEntity: selectedEntity,
            onSelection: (entity) => setState(() => selectedEntity = entity),
          ),
        ),
        if (selectedEntity != null) Expanded(child: EntityView(entity: selectedEntity!)),
      ],
    );
  }

  Future<PikaState> _fetchData() async {
    var client = serviceProvider.get<ApiClient>();
    DomainDto baseDomainDto = await client.getDomain('_');
    DomainDto domainDto = await client.getDomain(widget.domainId);
    UserStatsDto userStatsDto = await client.getUserStat(widget.domainId);
    return PikaState.fromDto(domainDto, baseDomainDto, userStatsDto);
  }
}
