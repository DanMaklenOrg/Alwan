import 'package:flutter/material.dart';

import '../domain/game_models.dart';

final class AchievementDetails extends StatelessWidget {
  const AchievementDetails({super.key, required this.achievement, });

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(achievement.name, style: Theme.of(context).textTheme.headlineSmall),
        // Expanded(child: _buildObjectiveList(context)),
      ],
    );
  }
  //
  // Widget _buildObjectiveList(BuildContext context) {
  //
  // }
}
//
// final class _ObjectiveList extends StatelessWidget {
//   const _ObjectiveList({super.key, required this.objectives, this.selected, this.onSelect});
//
//   final List<Objective> objectives;
//   final Objective? selected;
//   final void Function(Objective?)? onSelect;
//
//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       showCheckboxColumn: false,
//       columns: [
//         _buildColumnHeader(context, 'Title'),
//         _buildColumnHeader(context, 'Description'),
//         _buildColumnHeader(context, 'Progress'),
//       ],
//       rows: [for (var o in objectives) _buildRow(context, o)],
//     );
//   }
//
//   DataRow _buildRow(BuildContext context, Objective o) {
//     bool isSelected = selected != null && selected!.id == o.id;
//     var style = Theme.of(context).textTheme.bodyMedium!;
//     if (isSelected) style = style.apply(color: Theme.of(context).colorScheme.primary);
//     return DataRow(
//       onSelectChanged: (b) {
//         if (onSelect == null) return;
//         if (b ?? false)
//           onSelect!(o);
//         else
//           onSelect!(null);
//       },
//       selected: isSelected,
//       cells: [
//         DataCell(Text(o.name, style: _rowTextStyle(context, isSelected))),
//         _buildDescriptionCell(context, o, isSelected),
//         DataCell(Text('0/0'), placeholder: true),
//       ],
//     );
//   }
//
//   DataColumn _buildColumnHeader(BuildContext context, String header) {
//     return DataColumn(label: Text(header, style: Theme.of(context).textTheme.titleMedium));
//   }
//
//   DataCell _buildDescriptionCell(BuildContext context, Objective a, bool isSelected) {
//     return DataCell(ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 300),
//         child: Text(
//           a.description ?? '',
//           style: _rowTextStyle(context, isSelected),
//           overflow: TextOverflow.ellipsis,
//         )
//     ));
//   }
//
//   TextStyle? _rowTextStyle(BuildContext context, bool isSelected) =>
//       isSelected ? Theme.of(context).textTheme.bodyMedium!.apply(color: Theme.of(context).colorScheme.primary) : null;
// }
