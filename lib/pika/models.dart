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
  Stat({required this.id, required this.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  Stat.fromDto(StatDto s)
      : id = s.id,
        name = s.name,
        type = switch (s.type) {
          StatTypeEnumDto.boolean => StatType.boolean,
          StatTypeEnumDto.integerRange => StatType.integerRange,
          StatTypeEnumDto.orderedEnum => StatType.orderedEnum,
        },
        min = s.min,
        max = s.max,
        enumValues = s.enumValues;

  final String id;
  final String name;
  final StatType type;
  final int? min;
  final int? max;
  final List<String>? enumValues;

  bool isCompleted(String? val) {
    return switch (type) {
      StatType.boolean => val == "true",
      StatType.integerRange => val != null && int.parse(val) == max || min == max,
      StatType.orderedEnum => val == enumValues!.last,
    };
  }
}

enum StatType { boolean, integerRange, orderedEnum }
