import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/user_stats.dart';

import 'models.dart';

class DtoConverter {
  DtoConverter([this._container]);

  final PikaContainer? _container;

  Stat fromStatDto(StatDto dto) {
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

  Class fromClassDto(ClassDto dto) {
    return Class(
      id: ResourceId.fromString(dto.id),
      stats: [for (var sid in dto.stats) _container!.stats[ResourceId.fromString(sid)]!],
    );
  }

  Entity fromEntityDto(EntityDto dto) {
    return Entity(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
      stats: [for (var sid in dto.stats) _container!.stats[ResourceId.fromString(sid)]!],
      classes: [for (var cid in dto.classes) _container!.classes[ResourceId.fromString(cid)]!]
    );
  }

  Project fromProjectDto(ProjectDto dto) {
    return Project(id: ResourceId.fromString(dto.id), name: dto.name);
  }

  Domain fromDomainDto(DomainDto dto) {
    return Domain(id: dto.id, name: dto.name);
  }

  UserEntityStat fromUserEntityStatDto(UserEntityStatDto dto) {
    return UserEntityStat(
      entityId: ResourceId.fromString(dto.entityId),
      statId: ResourceId.fromString(dto.statId),
      value: dto.value,
    );
  }

  UserEntityStatDto toEntityUserStatDto(UserEntityStat stat) {
    return UserEntityStatDto(
      entityId: stat.entityId.fullyQualifiedId,
      statId: stat.statId.fullyQualifiedId,
      value: stat.value,
    );
  }
}
