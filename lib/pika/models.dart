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
  Stat({required this.id, required this.name, required this.type, this.min, this.max})
      : assert(type != StatType.integerRange || (min != null && max != null));

  final String id;
  final String name;
  final StatType type;
  final int? min;
  final int? max;
}

enum StatType { boolean, integerRange }
