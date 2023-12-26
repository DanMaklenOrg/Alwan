import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'service_provider.dart';
import 'routing.dart';

void main() {
  ServiceCollection.registerServices();
  usePathUrlStrategy();
  runApp(MaterialApp.router(
    title: 'Dan Maklen App',
    routerConfig: router,
  ));
}
