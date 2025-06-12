import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:flutter/material.dart';

import '../domain/game_models.dart';

final class AchievementDetails extends StatelessWidget {
  const AchievementDetails({super.key, required this.achievement, required this.selectedObjective, required this.onObjectiveSelect});

  final Achievement achievement;
  final Objective? selectedObjective;
  final ValueChanged<Objective?> onObjectiveSelect;

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
    return Container(
      constraints: BoxConstraints(maxHeight: 150),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(child: Text(achievement.description!)),
    );
  }

  Widget _buildProgressSummary(BuildContext context) {
    return Row(
      children: [
        _buildProgressCard('Overall', Icons.insights, 100),
        if(achievement.objectives.isNotEmpty) _buildProgressCard('Objective', Icons.task_alt, 100),
        if(achievement.criteriaCategory != null) _buildProgressCard('Criteria', Icons.checklist, 100, () {}),
      ],
    );
  }

  Widget _buildProgressCard(String title, IconData icon, int progress, [VoidCallback? onTap]) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 75,
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

  Widget _buildObjectiveList() {
    return AlwanDataTable<Objective>(
      values: achievement.objectives,
      columns: ['Objective Title', 'Description', 'Progress'],
      rowBuilder: (context, o, isSelected) => [
        AlwanDataCell.text(context, o.name, isSelected),
        AlwanDataCell.longText(context, o.description ?? '', isSelected),
        AlwanDataCell.checkBox(context, '??%', false, isSelected, () {}),
      ],
      selected: selectedObjective,
      onSelect: onObjectiveSelect,
    );
  }
}
