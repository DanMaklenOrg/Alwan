import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import 'description_box.dart';
import 'progress_card.dart';

final class AchievementDetails extends StatelessWidget {
  const AchievementDetails({super.key, required this.achievement, required this.selectedObjective, required this.onObjectiveSelect, required this.onChecklistTap});

  final Achievement achievement;
  final Objective? selectedObjective;
  final ValueChanged<Objective?> onObjectiveSelect;
  final VoidCallback onChecklistTap;

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      title: _buildTitle(context),
      progress: _buildProgressSummary(context),
      description: achievement.description == null ? null : _buildDescription(context),
      objectives: achievement.objectives.isEmpty ? null : _buildObjectiveList(),
    );
  }

  Widget _buildLayout({required Widget title, required Widget progress, required Widget? description, required Widget? objectives}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [SizedBox(width: 8), Expanded(child: title), progress, SizedBox(width: 4)],
        ),
        if (description != null) description,
        if (objectives != null) Expanded(child: objectives),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(achievement.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildDescription(BuildContext context) {
    return DescriptionBox(text: achievement.description!);
  }

  Widget _buildProgressSummary(BuildContext context) {
    return Row(
      children: [
        ProgressCard(title: 'Overall', icon: Icons.insights, progress: 100),
        if (achievement.objectives.isNotEmpty) ProgressCard(title: 'Objective', icon: Icons.task_alt, progress: 100),
        if (achievement.criteriaCategory != null) ProgressCard(title: 'Criteria', icon: Icons.checklist, progress: 100, onTap: onChecklistTap),
      ],
    );
  }

  Widget _buildObjectiveList() {
    return AlwanDataTable<Objective>(
      values: achievement.objectives,
      columns: ['Objective Title', 'Description', 'Progress'],
      rowBuilder: (context, o, isSelected) => [
        AlwanDataCell.text(context, o.name, isSelected),
        AlwanDataCell.longText(context, o.description ?? '', isSelected),
        AlwanDataCell.checkBox(context, '??%', o.progress.done.value, isSelected, () => o.progress.done.value = !o.progress.done.value),
      ],
      selected: selectedObjective,
      onSelect: onObjectiveSelect,
    );
  }
}
