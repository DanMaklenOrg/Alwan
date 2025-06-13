import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game_models.dart';
import '../domain/pika_progress.dart';
import 'pika_ui_state.dart';

class EntityChecklistPanel extends StatefulWidget {
  const EntityChecklistPanel({super.key, required this.criteria, required this.progressTracker, required this.hideCompleted});

  final Category criteria;
  final CriteriaProgress progressTracker;
  final bool hideCompleted;

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
    var entityList = widget.criteria.entities;
    if (widget.hideCompleted) entityList = entityList.where((e) => !widget.progressTracker.isEntityDone(e)).toList();
    return ListView.builder(
      itemCount: entityList.length,
      itemBuilder: (_, i) => CheckboxListTile(
        title: Text(entityList[i].name),
        value: widget.progressTracker.isEntityDone(entityList[i]),
        onChanged: (b) => onChanged(b, entityList[i]),
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
    pageBuilder: (_, __, ___) => EntityChecklistPanel(
      criteria: criteria,
      progressTracker: progressTracker,
      hideCompleted: context.watch<PikaUiState>().hideCompleted.value,
    ),
  );
}
