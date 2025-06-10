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
      children: [
        Text(achievement.name, style: Theme.of(context).textTheme.headlineSmall),
        _buildAlwanDataTable(),
      ],
    );
  }

  AlwanDataTable<Objective> _buildAlwanDataTable() {
    return AlwanDataTable<Objective>(
      values: achievement.objectives,
      columns: ['Title', 'Description', 'Progress'],
      rowBuilder: (context, o, isSelected) => [
        AlwanDataCell.text(context, o.name, isSelected),
        AlwanDataCell.longText(context, o.description ?? '', isSelected),
        AlwanDataCell.checkBox(context, false, (b) {}),
      ],
      selected: selectedObjective,
      onSelect: onObjectiveSelect,
    );
  }
}
