import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_sharp),
            onPressed: () => Navigator.of(context).pushNamed('/signin'),
          ),
        ],
      ),
      body: Center(child: body),
    );
  }
}
