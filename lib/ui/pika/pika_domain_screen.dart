import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_state.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<PikaState>(
      fetcher: _fetchData,
      builder: (context, state) =>
          BaseScreenLayout(
            title: state.domainName,
            body: Row(
              children: [
                Expanded(
                  child: EntityListView(
                    entities: state.entities,
                    selectedEntity: selectedEntity,
                    onSelection: (entity) => setState(() => selectedEntity = entity),
                  ),
                ),
                if (selectedEntity != null) Expanded(child: EntityView(entity: selectedEntity!)),
              ],
            ),
          ),
    );
  }

  Future<PikaState> _fetchData() async {
    DomainDto baseDomainDto = await serviceProvider.get<ApiClient>().getDomain('_');
    DomainDto domainDto = await serviceProvider.get<ApiClient>().getDomain(widget.domainId);
    return PikaState.fromDto(domainDto, baseDomainDto);
  }
}
