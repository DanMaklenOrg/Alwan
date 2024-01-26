import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
        title: 'Home',
        body: ElevatedButton(
          onPressed: () => context.go('/pika'),
          child: const Text('Go To Pika!'),
        ));
  }
}
