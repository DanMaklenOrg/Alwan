import 'package:alwan/pika/domain/game_models.dart';
import 'package:alwan/pika/domain/pika_progress.dart';
import 'package:flutter/material.dart';

import 'entity_checklist_panel.dart';

final class ProgressSummaryWidget extends StatelessWidget {
  const ProgressSummaryWidget({super.key, required this.progress, required this.criteria});

  final PikaProgress progress;
  final Category? criteria;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: progress,
        builder: (context, _, __) {
          return Row(
            children: [
              _ProgressCard(title: 'Overall', icon: Icons.insights, progress: progress.summary.percent),
              if (progress.dependents != null) _ProgressCard(title: 'Dependents', icon: Icons.task_alt, progress: progress.dependents!.summary.percent,),
              if (progress.criteria != null)
                _ProgressCard(
                  title: 'Criteria',
                  icon: Icons.checklist,
                  progress: progress.criteria!.summary.percent,
                  onTap: () => _showCriteriaChecklist(context),
                ),
            ],
          );
        });
  }

  void _showCriteriaChecklist(BuildContext context) {
    showEntityChecklistPanel(
      context,
      criteria: criteria!,
      progressTracker: progress.criteria!,
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.title, required this.icon, required this.progress, this.onTap}) : assert(progress >= 0 && progress <= 100);

  final String title;
  final IconData icon;
  final int progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 80,
          margin: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(icon), SizedBox(width: 4), Text('$progress%')],
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
