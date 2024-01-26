import 'package:alwan/api/dto.dart';

final class Domain {
  Domain({required this.id, required this.name, required this.entities});

  final String id;
  final String name;
  final List<Entity> entities;
}

final class Entity {
  Entity({required this.id, required this.name, required this.stats});

  final String id;
  final String name;
  final List<Stat> stats;
}

final class Stat {
  Stat({required this.id, required this.name, required this.type, this.min, this.max}) : assert(type != StatType.integerRange || (min != null && max != null));

  Stat.fromDto(StatDto s)
      : id = s.id,
        name = s.name,
        type = switch (s.type) {
          StatTypeEnumDto.boolean => StatType.boolean,
          StatTypeEnumDto.integerRange => StatType.integerRange,
        },
        min = s.min,
        max = s.max;

  final String id;
  final String name;
  final StatType type;
  final int? min;
  final int? max;

  bool isCompleted(int val) {
    return switch (type) {
      StatType.boolean => val == 1,
      StatType.integerRange => val == max,
    };
  }
}

enum StatType { boolean, integerRange }
