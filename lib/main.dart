import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/config.dart';
import 'package:alwan/ui/screens/pika_domain_screen.dart';
import 'package:alwan/ui/screens/pika_home_screen.dart';
import 'package:alwan/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  Config.buildConfig(const String.fromEnvironment('FLAVOR'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MaterialApp(
        title: 'Dan Maklen App',
        initialRoute: '/pika',
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case '/pika':
              return MaterialPageRoute(builder: (context) => const PikaHomeScreen());
            case '/pika/domain':
              return MaterialPageRoute(builder: (context) => PikaDomainScreen(domain: routeSettings.arguments as DomainDto));
            case '/signup':
              return MaterialPageRoute(builder: (context) => const SignInScreen());
            default:
              return null;
          }
        },
      ),
    );
  }
}
