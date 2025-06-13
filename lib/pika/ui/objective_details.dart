import 'package:alwan/pika/ui/progress_summary_widget.dart';
import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import 'description_box.dart';

final class ObjectiveDetails extends StatelessWidget {
  const ObjectiveDetails({super.key, required this.objective});

  final Objective objective;

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      title: _buildTitle(context),
      progress: ProgressSummaryWidget(progress: objective.progress, criteria: objective.criteriaCategory),
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
}
