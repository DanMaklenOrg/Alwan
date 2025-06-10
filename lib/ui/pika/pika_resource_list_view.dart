import 'package:alwan/pika/domain/game_models.dart';
import 'package:flutter/material.dart';

final class PikaResourceListView<T extends PikaResource> extends StatelessWidget {
  PikaResourceListView({super.key, required this.resourceList, required this.selectedResource, required this.onSelection}) {
    resourceList.sort();
  }

  final List<T> resourceList;
  final T? selectedResource;
  final void Function(T?) onSelection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resourceList.length,
      itemBuilder: (context, index) {
        final isSelected = resourceList[index].id == selectedResource?.id;
        return ListTile(
          title: Text(resourceList[index].name),
          selected: resourceList[index].id == selectedResource?.id,
          onTap: () => onSelection(isSelected ? null : resourceList[index]),
        );
      }
    );
  }
}
