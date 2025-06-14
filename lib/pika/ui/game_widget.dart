import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game_models.dart';
import 'achievement_details.dart';
import 'objective_details.dart';
import 'pika_data_cell.dart';
import 'pika_ui_state.dart';

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
      topRight: _selectedAchievement == null ? null : _buildAchievementDetails(context),
      bottomRight: _selectedObjective == null ? null : _buildObjectiveDetails(context),
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
              if (topRight != null) Expanded(flex: 2, child: topRight),
              if (bottomRight != null) ...[
                Divider(thickness: 4, height: 12, radius: BorderRadiusGeometry.circular(12)),
                Expanded(flex: 1, child: bottomRight),
              ]
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAchievementList() {
    return ValueListenableBuilder(
      valueListenable: widget.game.progress,
      builder: (context, __, ___) {
        var achList = widget.game.achievements.sortedBy((a) => a.name);
        if(context.watch<PikaUiState>().hideCompleted.value) achList = achList.where((a) => !a.progress.isCompleted).toList();
        return AlwanDataTable<Achievement>(
          values: achList,
          columns: ['Achievement Title', 'Description', 'Progress'],
          rowBuilder: (context, a, isSelected) => [
            AlwanDataCell.text(context, a.name, isSelected),
            AlwanDataCell.longText(context, a.description ?? '', isSelected),
            PikaDataCell.progressCell(progress: a.progress, isRowSelected: isSelected),
          ],
          selected: _selectedAchievement,
          onSelect: (a) => setState(() {
            _selectedObjective = null;
            _selectedAchievement = a;
          }),
        );
      }
    );
  }

  Widget _buildAchievementDetails(BuildContext context) {
    return AchievementDetails(
      achievement: _selectedAchievement!,
      selectedObjective: _selectedObjective,
      onObjectiveSelect: (o) => setState(() => _selectedObjective = o),
    );
  }

  Widget _buildObjectiveDetails(BuildContext context) {
    return ObjectiveDetails(objective: _selectedObjective!);
  }
}
