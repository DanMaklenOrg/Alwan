import 'package:alwan/pika/models.dart';
import 'package:alwan/ui/pika/pika_resource_list_view.dart';
import 'package:flutter/material.dart';

final class ProjectView extends StatelessWidget {
  const ProjectView({super.key, required this.project, required this.selectedObjective, required this.onSelection});

  final Project project;
  final Objective? selectedObjective;
  final void Function(Objective?) onSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(project.name, style: Theme.of(context).textTheme.headlineLarge),
        ),
        Expanded(
          child: PikaResourceListView<Objective>(
            resourceList: project.objectives,
            selectedResource: selectedObjective,
            onSelection: onSelection,
          ),
        ),
      ],
    );
  }
}
