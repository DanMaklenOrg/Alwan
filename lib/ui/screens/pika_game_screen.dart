import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:flutter/material.dart';

final class PikaGameScreen extends StatefulWidget {
  const PikaGameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<PikaGameScreen> createState() => _PikaGameScreenState();
}

class _PikaGameScreenState extends State<PikaGameScreen> {
  GameEntityDto? selectedEntity;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<GameDto>(
      fetcher: () async => await serviceProvider.get<ApiClient>().getGame(widget.gameId),
      builder: (context, game) => BaseScreenLayout(
        title: game.name,
        body: Row(
          children: [
            Expanded(
              child: GameEntityList(
                game: game,
                selectedEntity: selectedEntity,
                onSelection: (entity) => setState(() => selectedEntity = entity),
              ),
            ),
            if (selectedEntity != null) Expanded(child: GameEntityView(entity: selectedEntity!)),
          ],
        ),
      ),
    );
  }
}

final class GameEntityList extends StatelessWidget {
  const GameEntityList({super.key, required this.game, required this.selectedEntity, required this.onSelection});

  final GameDto game;
  final GameEntityDto? selectedEntity;
  final void Function(GameEntityDto) onSelection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: game.entities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(game.entities[index].name),
            selected: game.entities[index].id == selectedEntity?.id,
            onTap: () => onSelection(game.entities[index]),
          );
        });
  }
}

final class GameEntityView extends StatelessWidget {
  const GameEntityView({super.key, required this.entity});

  final GameEntityDto entity;

  @override
  Widget build(BuildContext context) {
    return Text(entity.name);
  }
}
