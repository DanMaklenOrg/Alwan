import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import 'description_box.dart';
import 'entity_checklist_panel.dart';
import 'progress_card.dart';

final class AchievementDetails extends StatefulWidget {
  const AchievementDetails(
      {super.key, required this.achievement, required this.selectedObjective, required this.onObjectiveSelect});

  final Achievement achievement;
  final Objective? selectedObjective;
  final ValueChanged<Objective?> onObjectiveSelect;

  @override
  State<AchievementDetails> createState() => _AchievementDetailsState();
}

class _AchievementDetailsState extends State<AchievementDetails> {
  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      title: _buildTitle(),
      progress: _buildProgressSummary(),
      description: widget.achievement.description == null ? null : _buildDescription(),
      objectives: widget.achievement.objectives.isEmpty ? null : _buildObjectiveList(),
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

  Widget _buildTitle() {
    return Text(widget.achievement.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildDescription() {
    return DescriptionBox(text: widget.achievement.description!);
  }

  Widget _buildProgressSummary() {
    return Row(
      children: [
        ProgressCard(title: 'Overall', icon: Icons.insights, progress: 100),
        if (widget.achievement.objectives.isNotEmpty) ProgressCard(title: 'Objective', icon: Icons.task_alt, progress: 100),
        if (widget.achievement.criteriaCategory != null) ProgressCard(title: 'Criteria', icon: Icons.checklist, progress: 100, onTap: _showCriteriaChecklist),
      ],
    );
  }

  Widget _buildObjectiveList() {
    return AlwanDataTable<Objective>(
      values: widget.achievement.objectives,
      columns: ['Objective Title', 'Description', 'Progress'],
      rowBuilder: (context, o, isSelected) => [
        AlwanDataCell.text(context, o.name, isSelected),
        AlwanDataCell.longText(context, o.description ?? '', isSelected),
        AlwanDataCell.checkBox(
          context,
          label: '??%',
          checked: o.progress.isCompleted,
          isRowSelected: isSelected,
          onTap: !o.progress.isManual ? null : () => setState(() => o.progress.manual!.toggle()),
        ),
      ],
      selected: widget.selectedObjective,
      onSelect: widget.onObjectiveSelect,
    );
  }

  void _showCriteriaChecklist() {
    showEntityChecklistPanel(
      context,
      criteria: widget.achievement.criteriaCategory!,
      progressTracker: widget.achievement.progress.criteria!,
    );
  }
}
