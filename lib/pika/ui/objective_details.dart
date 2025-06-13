import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import 'description_box.dart';
import 'entity_checklist_panel.dart';
import 'progress_card.dart';

final class ObjectiveDetails extends StatelessWidget {
  const ObjectiveDetails({super.key, required this.objective});

  final Objective objective;

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      title: _buildTitle(context),
      progress: _buildProgressSummary(context),
      description: objective.description == null ? null : _buildDescription(context),
    );
  }

  Widget _buildLayout({required Widget title, required Widget progress, required Widget? description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [SizedBox(width: 8), Expanded(child: title), progress, SizedBox(width: 4)],
        ),
        if (description != null) description,
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(objective.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildDescription(BuildContext context) {
    return DescriptionBox(text: objective.description!);
  }

  Widget _buildProgressSummary(BuildContext context) {
    return Row(
      children: [
        ProgressCard(title: 'Overall', icon: Icons.insights, progress: 100),
        if (objective.criteriaCategory != null)
          ProgressCard(
            title: 'Criteria',
            icon: Icons.checklist,
            progress: 100,
            onTap: () => _showCriteriaChecklist(context),
          ),
      ],
    );
  }

  void _showCriteriaChecklist(BuildContext context) {
    showEntityChecklistPanel(
      context,
      criteria: objective.criteriaCategory!,
      progressTracker: objective.progress.criteria!,
    );
  }
}
