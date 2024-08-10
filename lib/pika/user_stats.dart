import 'package:flutter/foundation.dart';

import 'models.dart';

class UserStats extends ChangeNotifier {
  UserStats(this.rootDomainId, List<UserEntityStat> userStats)
      : _rawDict = {for (var s in userStats) (s.entityId, s.statId): s.value};


  final String rootDomainId;
  final Map<(ResourceId, ResourceId), String> _rawDict;

  setStatValue(Entity entity, Stat stat, String val) {
    _rawDict[(entity.id, stat.id)] = val;
    notifyListeners();
  }

  String? getStatValue(Entity entity, Stat stat) {
    return _rawDict[(entity.id, stat.id)];
  }

  bool isEntityCompleted(Entity entity){
    return entity.stats.every((s) => isEntityStatCompleted(entity, s));
  }

  bool isEntityStatCompleted(Entity e, Stat s){
    var val = getStatValue(e, s);
    return switch (s.type) {
      StatType.boolean => val == "true",
      StatType.integerRange => val != null && int.parse(val) == s.max || s.min == s.max,
      StatType.orderedEnum => val == s.enumValues!.last,
    };
  }

  Iterable<UserEntityStat> getEntityStatList() => _rawDict.entries.map((e) => UserEntityStat(entityId: e.key.$1, statId: e.key.$2, value: e.value));
}

class UserEntityStat {
  UserEntityStat({required this.entityId, required this.statId, required this.value});

  ResourceId entityId;
  ResourceId statId;
  String value;
}
