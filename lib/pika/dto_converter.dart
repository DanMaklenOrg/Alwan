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
      name: dto.name,
      stats: [for (var sid in dto.stats) _container!.stats[ResourceId.fromString(sid.id)]!],
    );
  }

  Entity fromEntityDto(EntityDto dto) {
    var classList = [_container!.classes[ResourceId.fromString(dto.$class)]!];
    var statSet = {for (var sid in dto.stats) _container.stats[ResourceId.fromString(sid.id)]!};
    statSet.addAll(classList.expand((c) => c.stats));
    return Entity(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
      stats: statSet.toList(),
      classes: classList,
    );
  }

  Project fromProjectDto(ProjectDto dto) {
    return Project(
      id: ResourceId.fromString(dto.id),
      name: dto.name,
      objectives: [
        for (var o in dto.objectives)
          Objective(
            id: ResourceId.fromString(o.id),
            name: o.name,
            requirements: [
              for (var r in o.requirements)
                ObjectiveRequirement(
                  $class: _container!.classes[ResourceId.fromString(r.$class)]!,
                  stat: _container.stats[ResourceId.fromString(r.stat)]!,
                  min: r.min,
                )
            ],
          )
      ],
    );
  }

  Domain fromDomainDto(DomainDto dto) {
    return Domain(id: ResourceId.fromString(dto.id), name: dto.name);
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
