import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:flutter/material.dart';

import 'entity_list_view.dart';
import 'entity_view.dart';

final class PikaGameScreen extends StatefulWidget {
  const PikaGameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<PikaGameScreen> createState() => _PikaGameScreenState();
}

class _PikaGameScreenState extends State<PikaGameScreen> {
  EntityDto? selectedEntity;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<GameDto>(
      fetcher: () => serviceProvider.get<ApiClient>().getGame(widget.gameId),
      builder: (context, game) => BaseScreenLayout(
        title: game.name,
        body: Row(
          children: [
            Expanded(
              child: EntityListView(
                game: game,
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
