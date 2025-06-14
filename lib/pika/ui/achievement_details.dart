import 'package:alwan/pika/ui/pika_data_cell.dart';
import 'package:alwan/pika/ui/progress_summary_widget.dart';
import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game_models.dart';
import 'description_box.dart';
import 'pika_ui_state.dart';

final class AchievementDetails extends StatefulWidget {
  const AchievementDetails({super.key, required this.achievement, required this.selectedObjective, required this.onObjectiveSelect});

  final Achievement achievement;
  final Objective? selectedObjective;
  final ValueChanged<Objective?> onObjectiveSelect;

  @override
  State<AchievementDetails> createState() => _AchievementDetailsState();
}

class _AchievementDetailsState extends State<AchievementDetails> {
  @override
  Widget build(BuildContext context) {
    return _buildLayout(
      title: _buildTitle(),
      progress: ProgressSummaryWidget(progress: widget.achievement.progress, criteria: widget.achievement.criteriaCategory),
      description: widget.achievement.description == null ? null : _buildDescription(),
      objectives: widget.achievement.objectives.isEmpty ? null : _buildObjectiveList(),
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

  Widget _buildTitle() {
    return Text(widget.achievement.name, style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _buildDescription() {
    return DescriptionBox(text: widget.achievement.description!);
  }

  Widget _buildObjectiveList() {
    return ValueListenableBuilder(
      valueListenable: widget.achievement.progress,
      builder: (context, _, __) {
        var objList = widget.achievement.objectives.sortedBy((o) => o.name);
        if(context.watch<PikaUiState>().hideCompleted.value) objList = objList.where((o) => !o.progress.isCompleted).toList();
        return AlwanDataTable<Objective>(
          values: objList,
          columns: ['Objective Title', 'Description', 'Progress'],
          rowBuilder: (context, o, isSelected) => [
            AlwanDataCell.text(context, o.name, isSelected),
            AlwanDataCell.longText(context, o.description ?? '', isSelected),
            PikaDataCell.progressCell(progress: o.progress, isRowSelected: isSelected),
          ],
          selected: widget.selectedObjective,
          onSelect: widget.onObjectiveSelect,
        );
      }
    );
  }
}
