import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class ProjectListView extends StatelessWidget {
  const ProjectListView({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    var pikaContext = context.watch<PikaContext>();
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(projects[index].name),
            onChanged: (bool? value) => pikaContext.userStats.setProjectCompletionState(projects[index], value ?? false),
            value: pikaContext.userStats.isProjectCompleted(projects[index]),
          );
        });
  }
}
