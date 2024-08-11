import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/user_stats.dart';

import 'models.dart';

class DtoConverter {
  DtoConverter([this._container]);

  final PikaContainer? _container;

  Stat fromStatDto(StatDto dto) {
    return Stat(
      id: ResourceId(id: dto.id),
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
      id: ResourceId(id: dto.id),
      name: dto.name,
      stats: [for (var s in dto.stats) fromStatDto(s)],
    );
  }

  Entity fromEntityDto(EntityDto dto) {
    var $class = _container!.classes[ResourceId(id: dto.$class)]!;
    return Entity(
      id: ResourceId(id: dto.id),
      name: dto.name,
      $class: $class,
      stats: [for (var s in dto.stats) fromStatDto(s)],
    );
  }

  Project fromProjectDto(ProjectDto dto) {
    return Project(
      id: ResourceId(id: dto.id),
      name: dto.name,
      objectives: [
        for (var o in dto.objectives)
          Objective(
            id: ResourceId(id: o.id),
            name: o.name,
            requirements: [
              for (var r in o.requirements)
                ObjectiveRequirement(
                  $class: ResourceId(id: r.$class),
                  stat: ResourceId(id: r.stat),
                  min: r.min,
                )
            ],
          )
      ],
    );
  }

  Domain fromDomainDto(DomainDto dto) {
    return Domain(id: ResourceId(id: dto.id), name: dto.name);
  }

  UserEntityStat fromUserEntityStatDto(UserEntityStatDto dto) {
    return UserEntityStat(
      entityId: ResourceId(id: dto.entityId),
      statId: ResourceId(id: dto.statId),
      value: dto.value,
    );
  }

  UserEntityStatDto toEntityUserStatDto(UserEntityStat stat) {
    return UserEntityStatDto(
      entityId: stat.entityId.toString(),
      statId: stat.statId.toString(),
      value: stat.value,
    );
  }
}
