import 'package:flutter/material.dart';

import '../domain/game_models.dart';

class EntityChecklistPanel extends StatelessWidget {
  const EntityChecklistPanel({super.key, required this.entityList, required this.progressTracker});

  final List<Entity> entityList;
  final PikaProgress progressTracker;

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
      itemCount: entityList.length,
      itemBuilder: (_, i) => CheckboxListTile(
        title: Text(entityList[i].name),
        value: false,
        onChanged: (b) => onChanged(b, entityList[i]),
      ),
    );
  }

  void onChanged(bool? b, Entity e) {
    if (b ?? false)
      progressTracker.setEntityAsDone(e);
    else
      progressTracker.setEntityAsNotDone(e);
  }
}

void showEntityChecklistPanel(BuildContext context, {required List<Entity> entityList, required PikaProgress progressTracker}) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'DismissChecklistSideSheet',
    barrierDismissible: true,
    pageBuilder: (_, __, ___) => EntityChecklistPanel(entityList: entityList, progressTracker: progressTracker),
  );
}
