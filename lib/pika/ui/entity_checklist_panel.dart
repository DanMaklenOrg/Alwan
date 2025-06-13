import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import '../domain/pika_progress.dart';

class EntityChecklistPanel extends StatefulWidget {
  const EntityChecklistPanel({super.key, required this.criteria, required this.progressTracker});

  final Category criteria;
  final CriteriaProgress progressTracker;

  @override
  State<EntityChecklistPanel> createState() => _EntityChecklistPanelState();
}

class _EntityChecklistPanelState extends State<EntityChecklistPanel> {
  @override
  Widget build(BuildContext context) {
    return _buildLayout(Column(children: [
      SizedBox(height: 8),
      Text('Checklist', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.left),
      SizedBox(height: 8),
      Expanded(child: _buildList()),
    ]));
  }

  Widget _buildLayout(Widget child) {
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.3,
        child: Material(child: child),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: widget.criteria.entities.length,
      itemBuilder: (_, i) => CheckboxListTile(
        title: Text(widget.criteria.entities[i].name),
        value: widget.progressTracker.isEntityDone(widget.criteria.entities[i]),
        onChanged: (b) => onChanged(b, widget.criteria.entities[i]),
      ),
    );
  }

  void onChanged(bool? b, Entity e) {
    if (b ?? false)
      setState(() => widget.progressTracker.setEntityAsDone(e));
    else
      setState(() => widget.progressTracker.setEntityAsNotDone(e));
  }
}

void showEntityChecklistPanel(BuildContext context, {required Category criteria, required CriteriaProgress progressTracker}) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'DismissChecklistSideSheet',
    barrierDismissible: true,
    pageBuilder: (_, __, ___) => EntityChecklistPanel(criteria: criteria, progressTracker: progressTracker),
  );
}
