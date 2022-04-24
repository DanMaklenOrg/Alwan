import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/ui/screens/pika_domain_screen.dart';
import 'package:alwan/ui/screens/pika_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dan Maklen App',
      initialRoute: '/pika',
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case '/pika':
            return MaterialPageRoute(builder: (context) => const PikaHomeScreen());
          case '/pika/domain':
            return MaterialPageRoute(builder: (context) => PikaDomainScreen(domain: routeSettings.arguments as DomainDto));
          default:
            return null;
        }
      },
    );
  }
}
