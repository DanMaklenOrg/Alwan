import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/ui/screens/pika_domain_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var domain = DomainDto.fromJson({'id': 'f925381e6af4402ab0aad07861e403df', 'name': 'Warframe'});
    return MaterialApp(
      title: 'Dan Maklen App',
      home: PikaDomainScreen(domain: domain),
    );
  }
}
