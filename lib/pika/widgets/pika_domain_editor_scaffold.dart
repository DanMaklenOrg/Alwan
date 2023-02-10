import 'package:alwan/pika/models/domain.dart';
import 'package:alwan/ui/common/navigation_scaffold.dart';
import 'package:flutter/material.dart';

class PikaDomainEditorScaffold extends StatelessWidget {
  const PikaDomainEditorScaffold({
    super.key,
    required this.domain,
    required this.selected,
    required this.body,
  });

  final Domain domain;
  final int selected;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      title: domain.name,
      entries: [
        NavigationEntry(title: 'Entities', route: '/pika/edit/entity', arguments: domain, selected: selected == 0),
        NavigationEntry(title: 'Tags', route: '/pika/edit/tag', arguments: domain, selected: selected == 1),
        NavigationEntry(title: 'Actions', route: '/pika/edit/action', arguments: domain, selected: selected == 2),
        NavigationEntry(title: 'Projects', route: '/pika/edit/project', arguments: domain, selected: selected == 3),
      ],
      body: body,
    );
  }
}
