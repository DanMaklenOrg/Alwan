import 'package:alwan/pika/domain/game_models.dart';
import 'package:alwan/pika/ui/achievement_details.dart';
import 'package:flutter/material.dart';

import '../../ui/building_blocks/alwan_data_table.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key, required this.game});

  final Game game;

  @override
  State<GameWidget> createState() => _GameViewState();
}

class _GameViewState extends State<GameWidget> {
  Achievement? _selectedAchievement;
  Objective? _selectedObjective;

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      left: _buildAchievementList(),
      topRight: _buildAchievementDetails(),
    );
  }

  Widget _buildLayout({required Widget left, Widget? topRight, Widget? bottomRight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        Expanded(
          child: Column(
            children: [
              if (topRight != null) Expanded(child: topRight),
              if (bottomRight != null) Expanded(child: bottomRight),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAchievementList() {
    return AlwanDataTable<Achievement>(
      values: widget.game.achievements,
      columns: ['Title', 'Description', 'Progress'],
      rowBuilder: (context, a, isSelected) =>
      [
        AlwanDataCell.text(context, a.name, isSelected),
        AlwanDataCell.longText(context, a.description ?? '', isSelected),
        AlwanDataCell.checkBox(context, false, (b) {}),
      ],
      selected: _selectedAchievement,
      onSelect: (a) => setState(() => _selectedAchievement = a),
    );
  }

  AchievementDetails? _buildAchievementDetails() {
    if (_selectedAchievement == null) return null;
    return AchievementDetails(achievement: _selectedAchievement!);
  }
}
