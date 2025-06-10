import 'package:alwan/pika/game_models.dart';
import 'package:alwan/ui/pika/pika_resource_list_view.dart';
import 'package:flutter/material.dart';

final class AchievementView extends StatelessWidget {
  const AchievementView({super.key, required this.achievement, required this.selectedObjective, required this.onSelection});

  final Achievement achievement;
  final Objective? selectedObjective;
  final void Function(Objective?) onSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(achievement.name, style: Theme.of(context).textTheme.headlineLarge),
        ),
        Expanded(
          child: PikaResourceListView<Objective>(
            resourceList: achievement.objectives,
            selectedResource: selectedObjective,
            onSelection: onSelection,
          ),
        ),
      ],
    );
  }
}
