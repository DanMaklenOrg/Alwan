import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class Config {
  Config.buildConfig(String flavor) {
    switch (flavor.toLowerCase()) {
      case 'dev':
      case 'development':
        _buildDevelopmentEnvironment();
        break;
      case 'prod':
      case 'production':
      case '':
        _buildProductionEnvironment();
        break;
      default:
        throw ArgumentError.value(flavor, 'flavor', 'Unknown Flavor Value');
    }
  }

  static T getValue<T>(String configKey) => FlavorConfig.instance.variables[configKey] as T;

  static void _buildDevelopmentEnvironment() {
    FlavorConfig(
      name: "DEV",
      color: Colors.deepPurple,
      variables: _buildConfigVariables(
        clientHost: 'localhost',
      ),
    );
  }

  static void _buildProductionEnvironment() {
    FlavorConfig(
      variables: _buildConfigVariables(
        clientHost: 'svc.danmaklen.com',
      ),
    );
  }

  static Map<String, dynamic> _buildConfigVariables({
    required String clientHost,
    int pikaClientPort = 55501,
    int anaClientPort = 55502,
  }) {
    return {
      'clientHost': clientHost,
      'pikaClientPort': pikaClientPort,
      'anaClientPort': anaClientPort,
    };
  }
}
