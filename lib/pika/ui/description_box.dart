import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 150),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(child: Text(text)),
    );
  }
}
