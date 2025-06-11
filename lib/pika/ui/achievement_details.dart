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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(context),
        Row(
          children: [
            Expanded(child: _buildDescription()),
            _buildProgressSummary(context),
          ],
        ),
        Expanded(child: _buildObjectiveList()),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(achievement.name, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center);
  }

  Widget _buildDescription() {
    if (achievement.description == null) return Container();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 5, style: BorderStyle.solid, strokeAlign: 2)
      ),
      padding: EdgeInsets.all(8),
      child: Text(achievement.description!),
    );
  }

  Widget _buildProgressSummary(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildProgressCard(context, 'Overall', Icons.insights, 100),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context, String title, IconData icon, int progress) {
    return Card(
      child: Column(
        children: [
          Icon(icon),
          Text(title),
          Text('$progress%'),
        ],
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
