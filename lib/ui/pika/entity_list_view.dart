import 'package:alwan/api/dto.dart';
import 'package:flutter/material.dart';

final class EntityListView extends StatelessWidget {
  const EntityListView({super.key, required this.domain, required this.selectedEntity, required this.onSelection});

  final DomainDto domain;
  final EntityDto? selectedEntity;
  final void Function(EntityDto) onSelection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: domain.entities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(domain.entities[index].name),
          selected: domain.entities[index].id == selectedEntity?.id,
          onTap: () => onSelection(domain.entities[index]),
        );
      }
    );
  }
}
