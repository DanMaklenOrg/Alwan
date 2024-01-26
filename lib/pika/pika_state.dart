import 'package:alwan/api/dto.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class PikaState extends ChangeNotifier {
  PikaState.fromDto(DomainDto domainDto, DomainDto baseDomainDto)
      : domainId = domainDto.id,
        domainName = domainDto.name {
    final flattenedDomains = [domainDto, ...domainDto.subDomains, baseDomainDto, ...baseDomainDto.subDomains];
    stats = {
      for (var s in flattenedDomains.expand((d) => d.stats))
        s.id: Stat(
          id: s.id,
          name: s.name,
          type: switch (s.type) {
            StatTypeEnumDto.boolean => StatType.boolean,
            StatTypeEnumDto.integerRange => StatType.integerRange,
          },
          min: s.min,
          max: s.max,
        )
    };

    entities = flattenedDomains
        .expand((d) => d.entities)
        .map((e) => Entity(
              id: e.id,
              name: e.name,
              stats: e.stats.map((sid) => stats[sid]!).toList(),
            ))
        .toList();
  }

  final String domainId;
  final String domainName;

  late List<Entity> entities = [];
  late Map<String, Stat> stats = {};

  final Map<(String, String), int> _statValues = {};

  setStatValue(Entity entity, Stat stat, int val) {
    _statValues[(entity.id, stat.id)] = val;
    notifyListeners();
  }

  int? getStatValue(Entity entity, Stat stat) {
    return _statValues[(entity.id, stat.id)];
  }

  void save() {}

  List<Entity> getEntities({bool filterCompleted = false}) {
    if (!filterCompleted) return entities;
    return entities.where((e) => e.stats.any((s) => !s.isCompleted(getStatValue(e, s) ?? 0))).toList();
  }
}
