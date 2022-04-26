import 'package:alwan/api/dto/common/entry_dto.dart';
import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/pika/domain_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class ObjectivesDialog extends StatelessWidget {
  const ObjectivesDialog({
    Key? key,
    required this.entry,
    required this.objectives,
    required this.data,
  }) : super(key: key);

  static Future<void> show(BuildContext context, EntryDto entry, List<ObjectiveDto> objectives, DomainData domainData) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ObjectivesDialog(entry: entry, objectives: objectives, data: domainData),
    );
  }

  final EntryDto entry;
  final DomainData data;
  final List<ObjectiveDto> objectives;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(entry.title),
      actions: [_buildSubmitButton(context)],
      content: Container(
        constraints: const BoxConstraints(minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: objectives.map<Widget>((e) => _buildObjectiveEntry(e)).toList(),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Save Progress'),
    );
  }

  Widget _buildObjectiveEntry(ObjectiveDto objective) {
    return SpinBox(
      min: 0,
      max: 1.0 * objective.requiredCount,
      value: 1.0 * data.getProgress(entry.id, objective.id),
      onChanged: (val) => data.setProgress(entry.id, objective.id, val as int),
      decoration: InputDecoration(
        labelText: objective.title,
        suffixText: '/ ${objective.requiredCount}',
      ),
    );
  }
}
