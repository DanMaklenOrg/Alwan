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

  String domainId;
  String domainName;

  List<Entity> entities = [];
  Map<String, Stat> stats = {};
}
