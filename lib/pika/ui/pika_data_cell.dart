import 'package:alwan/ui/building_blocks/alwan_data_table.dart';
import 'package:flutter/material.dart';

import '../domain/pika_progress.dart';

sealed class PikaDataCell {
  static DataCell progressCell({required PikaProgress progress, required bool isRowSelected}) {
    return DataCell(
      ValueListenableBuilder(
        valueListenable: progress,
        builder: (context, value, child) {
          return IgnorePointer(
            child: Row(
              children: [
                Checkbox(value: progress.isCompleted, onChanged: progress.isManual ? (_) {} : null),
                Text('${progress.summary.percent}%', style: AlwanDataCell.textStyle(context, isRowSelected)),
              ],
            ),
          );
        },
      ),
      onTap: () => progress.manual?.toggle(),
    );
  }
}
