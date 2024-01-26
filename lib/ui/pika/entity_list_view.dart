import 'package:alwan/pika/models.dart';
import 'package:flutter/material.dart';

final class EntityListView extends StatelessWidget {
  const EntityListView({super.key, required this.entities, required this.selectedEntity, required this.onSelection});

  final List<Entity> entities;
  final Entity? selectedEntity;
  final void Function(Entity) onSelection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(entities[index].name),
          selected: entities[index].id == selectedEntity?.id,
          onTap: () => onSelection(entities[index]),
        );
      }
    );
  }
}
