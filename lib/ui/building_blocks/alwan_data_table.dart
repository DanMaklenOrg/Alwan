import 'package:flutter/material.dart';

class AlwanDataTable<T> extends StatelessWidget {
  const AlwanDataTable({super.key, required this.values, required this.columns, required this.rowBuilder, required this.selected, required this.onSelect});

  final List<T> values;
  final List<String> columns;
  final List<DataCell> Function(BuildContext context, T value, bool isSelected) rowBuilder;
  final ValueChanged<T?> onSelect;
  final T? selected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        showCheckboxColumn: false,
        columns: [for (var c in columns) _buildHeader(context, c)],
        rows: [for (var v in values) _buildRow(context, v)],
      ),
    );
  }

  DataColumn _buildHeader(BuildContext context, String header) {
    return DataColumn(label: Text(header, style: Theme.of(context).textTheme.titleMedium));
  }

  DataRow _buildRow(BuildContext context, T value) {
    bool isSelected = selected != null && selected! == value;
    return DataRow(
      onSelectChanged: (b) => onSelect(b ?? false ? value : null),
      selected: isSelected,
      cells: rowBuilder(context, value, isSelected),
    );
  }
}

sealed class AlwanDataCell {
  static DataCell text(BuildContext context, String text, bool isRowSelected) {
    return DataCell(Text(text, style: _textStyle(context, isRowSelected)));
  }

  static DataCell longText(BuildContext context, String text, bool isRowSelected) {
    return DataCell(
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Text(
          text,
          style: _textStyle(context, isRowSelected),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  static DataCell checkBox(BuildContext context, String label, bool checked, bool isRowSelected, VoidCallback onTap) {
    return DataCell(
      IgnorePointer(
        child: Row(
          children: [
            Checkbox(value: checked, onChanged: (_) {}),
            Text(label, style: _textStyle(context, isRowSelected)),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  static TextStyle? _textStyle(BuildContext context, bool isSelected) =>
      isSelected ? Theme.of(context).textTheme.bodyMedium!.apply(color: Theme.of(context).colorScheme.primary) : null;
}
