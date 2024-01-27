import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class PikaState extends ChangeNotifier {
  PikaState.fromDto(DomainDto domainDto, DomainDto baseDomainDto, UserStatsDto userStatsDto)
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

    _statValues = {for (var entityStat in userStatsDto.entityStats) (entityStat.entityId, entityStat.statId): entityStat.value};
  }

  final String domainId;
  final String domainName;

  late List<Entity> entities = [];
  late Map<String, Stat> stats = {};
  late Map<(String, String), int> _statValues = {};

  setStatValue(Entity entity, Stat stat, int val) {
    _statValues[(entity.id, stat.id)] = val;
    notifyListeners();
  }

  int? getStatValue(Entity entity, Stat stat) {
    return _statValues[(entity.id, stat.id)];
  }

  List<Entity> getEntities({bool hideCompleted = false}) {
    var filteredEntities = entities;
    if (hideCompleted) filteredEntities = filteredEntities.where((e) => e.stats.any((s) => !s.isCompleted(getStatValue(e, s) ?? 0))).toList();
    filteredEntities.sort((a, b) => a.name.compareTo(b.name));
    return filteredEntities;
  }

  Future save() async {
    var userStatsDto = UserStatsDto(entityStats: _statValues.entries.map((e) => UserEntityStat(entityId: e.key.$1, statId: e.key.$2, value: e.value)).toList());
    await serviceProvider.get<ApiClient>().setUserStat(domainId, userStatsDto);
  }
}
