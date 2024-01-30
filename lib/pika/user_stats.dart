import 'package:flutter/foundation.dart';

import 'models.dart';

class UserStats extends ChangeNotifier {
  UserStats.fromDictionary(this._rawDict);

  final Map<(ResourceId, ResourceId), String> _rawDict;

  setStatValue(Entity entity, Stat stat, String val) {
    _rawDict[(entity.id, stat.id)] = val;
    notifyListeners();
  }

  String? getStatValue(Entity entity, Stat stat) {
    return _rawDict[(entity.id, stat.id)];
  }

  Iterable<(ResourceId entityId, ResourceId statId, String value)> toIterable() {
    return _rawDict.entries.map((e) => (e.key.$1, e.key.$2, e.value));
  }
}
