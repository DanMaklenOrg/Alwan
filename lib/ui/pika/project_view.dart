import 'package:alwan/pika/models.dart';
import 'package:flutter/material.dart';

final class ProjectView extends StatelessWidget {
  const ProjectView({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(project.name, style: Theme.of(context).textTheme.headlineLarge),
        ),
        Expanded(child: _buildObjectiveList()),
      ],
    );
  }

  Widget _buildObjectiveList() {
    return ListView.separated(
      itemCount: project.objectives.length,
      itemBuilder: (context, index) => _buildObjective(context, project.objectives[index]),
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  Widget _buildObjective(BuildContext context, Objective objective) {
    return Text(objective.title);
  }
}
