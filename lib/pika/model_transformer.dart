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
      projects: [for (var p in dto.projects) _fromProjectDto(p)]
    );
  }

  Project _fromProjectDto(ProjectDto dto) {
    return Project(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
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

    var completedProjects = dto.completedProjectIds.map(ResourceId.fromString).toSet();

    return UserStats(dict, completedProjects);
  }

  UserStatsDto toUserStatsDto(UserStats stats) {
    var entityStats = stats.entityStatList.map<UserEntityStatDto>((e) =>
        UserEntityStatDto(entityId: e.entityId.fullyQualifiedId, statId: e.statId.fullyQualifiedId, value: e.value)).toList();
    var completedProjects = stats.completedProjects.map((e) => e.fullyQualifiedId).toList();
    return UserStatsDto(entityStats: entityStats, completedProjectIds: completedProjects);
  }
}
