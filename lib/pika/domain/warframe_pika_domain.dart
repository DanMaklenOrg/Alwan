import 'dart:async';
import 'dart:convert';

import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/pika/pika_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarframePikaDomain extends PikaDomain {
  PikaEntry? _root;

  static const String _storageKey = 'WarframePikaManager.domain';

  @override
  PikaEntry get root => _root!;

  @override
  bool get isLoaded => _root != null;

  @override
  Future<bool> save() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final String json = jsonEncode(root);
    return await storage.setString(_storageKey, json);
  }

  @override
  Future<bool> load() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final String? json = storage.getString(_storageKey);
    _root = json == null ? _def : PikaEntry.fromJson(jsonDecode(json));
    return true;
  }

  static final PikaEntry _def = PikaEntry('Warframe', children: [
    PikaEntry(
      'Max MR',
      children: [
        PikaEntry(
          'Warframes',
          children: [
            PikaEntry('Ember'),
            PikaEntry('EmberPrime'),
            PikaEntry('Excalibre'),
          ],
        ),
        PikaEntry(
          'Melee Weapons',
          children: [
            PikaEntry('Bo'),
            PikaEntry('Bo Prime'),
          ],
        )
      ],
    ),
    PikaEntry(
      'Own All Equipment',
      children: [
        PikaEntry(
          'Warframes',
          children: [
            PikaEntry('Equinox'),
            PikaEntry('Equinox Prime'),
            PikaEntry('Excalibre Umbra'),
          ],
        ),
        PikaEntry(
          'Primary Weapons',
          children: [
            PikaEntry('Braton'),
            PikaEntry('Braton Prime'),
          ],
        )
      ],
    ),
  ]);
}
