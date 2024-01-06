import 'package:flutter/material.dart';

class BaseScreenLayout extends StatelessWidget {
  const BaseScreenLayout({
    super.key,
    required this.title,
    required this.body
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: body),
    );
  }
}
