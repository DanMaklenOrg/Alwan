import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/pika/pika_progress_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class ObjectivesDialog extends StatefulWidget {
  const ObjectivesDialog._({
    Key? key,
    required this.entry,
    required this.objectiveLines,
  }) : super(key: key);

  static Future<Map<ObjectiveDto, Progress>> show(BuildContext context, PikaEntry entry, List<ObjectiveDto> objectives, PikaProgressTracker progressTracker) async {
    Map<ObjectiveDto, Progress> objectiveLines = { for (var obj in objectives) obj: progressTracker.getEntryObjectiveProgress(entry, obj)};
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ObjectivesDialog._(entry: entry, objectiveLines: objectiveLines),
    );
  }

  final PikaEntry entry;
  final Map<ObjectiveDto, Progress> objectiveLines;

  @override
  State<ObjectivesDialog> createState() => _ObjectivesDialogState();
}

class _ObjectivesDialogState extends State<ObjectivesDialog> {
  final Set<ObjectiveDto> modifiedObjectives = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.entry.title),
      actions: [_buildSubmitButton(context)],
      content: Container(
        constraints: const BoxConstraints(minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.objectiveLines.keys.map((e) => _buildObjectiveEntry(e)).toList(),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop({ for (var e in modifiedObjectives) e : widget.objectiveLines[e]! }),
      child: const Text('Save Progress'),
    );
  }

  Widget _buildObjectiveEntry(ObjectiveDto objective) {
    Progress progress = widget.objectiveLines[objective]!;
    return SpinBox(
      min: 0,
      max: progress.outOf as double,
      value: progress.progress as double,
      onChanged: (val) {
        progress.progress = val as int;
        modifiedObjectives.add(objective);
      },
      decoration: InputDecoration(
        labelText: objective.title,
        suffixText: '/ ${progress.outOf}',
      ),
    );
  }
}
