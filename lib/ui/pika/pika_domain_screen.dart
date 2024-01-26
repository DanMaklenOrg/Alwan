import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
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
  EntityDto? selectedEntity;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<DomainDto>(
      fetcher: () => serviceProvider.get<ApiClient>().getDomain(widget.domainId),
      builder: (context, domain) => BaseScreenLayout(
        title: domain.name,
        body: Row(
          children: [
            Expanded(
              child: EntityListView(
                domain: domain,
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
}
