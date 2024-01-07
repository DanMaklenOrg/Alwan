import 'package:alwan/api/dto.dart';
import 'package:flutter/material.dart';

final class EntityListView extends StatelessWidget {
  const EntityListView({super.key, required this.game, required this.selectedEntity, required this.onSelection});

  final GameDto game;
  final EntityDto? selectedEntity;
  final void Function(EntityDto) onSelection;

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
      }
    );
  }
}
