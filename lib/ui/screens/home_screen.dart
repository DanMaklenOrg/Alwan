import 'package:alwan/building_blocks/base_screen_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
        title: 'Home',
        body: ElevatedButton(
          onPressed: () {},
          child: const Text('Hello World!'),
        ));
  }
}
