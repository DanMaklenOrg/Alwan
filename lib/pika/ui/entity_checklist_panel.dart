import 'package:flutter/material.dart';

import '../domain/game_models.dart';

class EntityChecklistPanel extends StatelessWidget {
  const EntityChecklistPanel({super.key, required this.entityList});

  final List<Entity> entityList;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        // color: Colors.white,
        child: Container(
          width: 300,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Text("Checklist", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...entityList.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return CheckboxListTile(
                  title: Text(item.name),
                  value: false,
                  onChanged: (val) {
                    // setState(() => item.isChecked = val ?? false);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     child: Container(
  //       width: 300,
  //       child: ListView.builder(
  //           itemCount: entityList.length,
  //           itemBuilder: (context, index) {
  //             return CheckboxListTile(
  //               title: Text(entityList[index].name),
  //               value: false,
  //               onChanged: (b) {},
  //             );
  //           }),
  //     ),
  //   );
  // }
}

void showEntityChecklistPanel(BuildContext context, {required List<Entity> entityList}) {
  showGeneralDialog(
    context: context,

    pageBuilder: (_, __, ___) => EntityChecklistPanel(entityList: entityList),
  );
}
