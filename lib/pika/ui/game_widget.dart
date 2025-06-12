import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:flutter/material.dart';

import '../domain/game_models.dart';
import 'achievement_details.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key, required this.game});

  final Game game;

  @override
  State<GameWidget> createState() => _GameViewState();
}

class _GameViewState extends State<GameWidget> {
  Achievement? _selectedAchievement;
  Objective? _selectedObjective;

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      left: _buildAchievementList(),
      topRight: _selectedAchievement == null ? null : _buildAchievementDetails(),
      bottomRight: _selectedObjective == null ? null : _buildObjectiveDetails(),
    );
  }

  Widget _buildLayout({required Widget left, Widget? topRight, Widget? bottomRight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: 32),
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
      columns: ['Achievement Title', 'Description', 'Progress'],
      rowBuilder: (context, a, isSelected) => [
        AlwanDataCell.text(context, a.name, isSelected),
        AlwanDataCell.longText(context, a.description ?? '', isSelected),
        AlwanDataCell.checkBox(context, '??%', progress, isSelected, () => setState(() => progress = !progress)),
      ],
      selected: _selectedAchievement,
      onSelect: (a) => setState(() {
        _selectedObjective = null;
        _selectedAchievement = a;
      }),
    );
  }

  Widget _buildAchievementDetails() {
    return AchievementDetails(
      achievement: _selectedAchievement!,
      selectedObjective: _selectedObjective,
      onObjectiveSelect: (o) => setState(() => _selectedObjective = o),
    );
  }

  Widget _buildObjectiveDetails() {
    return AchievementDetails(
      achievement: _selectedAchievement!,
      selectedObjective: _selectedObjective,
      onObjectiveSelect: (o) => setState(() => _selectedObjective = o),
    );
  }
}
