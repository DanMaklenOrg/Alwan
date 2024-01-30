import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/user_stats.dart';

import 'models.dart';

class ModelTransformer {
  Domain domainFromDto(DomainDto dto) {
    return Domain(
      id: dto.id,
      name: dto.name,
      entities: [for (var e in dto.entities) _fromEntityDto(e)],
      stats: {for (var s in dto.stats.map(_fromStatDto)) s.id: s},
      subDomains: [for (var d in dto.subDomains) domainFromDto(d)],
    );
  }

  Entity _fromEntityDto(EntityDto dto) {
    return Entity(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
      stats: dto.stats.map(ResourceId.fromString).toList(),
    );
  }

  Stat _fromStatDto(StatDto dto) {
    return Stat(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
      type: switch (dto.type) {
        StatTypeEnumDto.boolean => StatType.boolean,
        StatTypeEnumDto.integerRange => StatType.integerRange,
        StatTypeEnumDto.orderedEnum => StatType.orderedEnum,
      },
      min: dto.min,
      max: dto.max,
      enumValues: dto.enumValues,
    );
  }

  UserStats fromUserStatsDto(UserStatsDto dto) {
    var dict = {
      for (var entityStat in dto.entityStats)
        (
          ResourceId.fromString(entityStat.entityId),
          ResourceId.fromString(entityStat.statId),
        ): entityStat.value
    };
    return UserStats.fromDictionary(dict);
  }

  UserStatsDto toUserStatsDto(UserStats stats) {
    return UserStatsDto(
        entityStats: stats.toIterable().map<UserEntityStatDto>((e) {
      var (entityId, statId, value) = e;
      return UserEntityStatDto(entityId: entityId.fullyQualifiedId, statId: statId.fullyQualifiedId, value: value);
    }).toList());
  }
}
