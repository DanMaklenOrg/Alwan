import 'package:alwan/pika/domain/warframe_pika_domain.dart';
import 'package:alwan/pika_domain_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dan Maklen App',
      home: PikaDomainScreen(domain: WarframePikaDomain(),),
    );
  }
}
