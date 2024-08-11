final class ResourceId implements Comparable<ResourceId> {
  ResourceId({required this.id});

  final String id;

  @override
  bool operator ==(Object other) => other is ResourceId && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => id;

  @override
  int compareTo(ResourceId other) => id.compareTo(other.id);
}

abstract class PikaResource implements Comparable<PikaResource> {
  PikaResource({required this.id, required this.name});

  final ResourceId id;
  final String name;

  @override
  bool operator ==(Object other) => other is PikaResource && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => "$id ($name)";

  @override
  int compareTo(PikaResource other) => name.compareTo(other.name);
}

final class Domain extends PikaResource {
  Domain({required super.id, required super.name});
}

final class Project extends PikaResource {
  Project({required super.id, required super.name, required this.objectives});

  List<Objective> objectives;
}

final class Objective extends PikaResource {
  Objective({required super.id, required super.name, required this.requirements});

  final List<ObjectiveRequirement> requirements;
}

final class ObjectiveRequirement {
  ObjectiveRequirement({required this.$class, required this.stat, required this.min});

  final ResourceId $class;
  final ResourceId stat;
  final int min;
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, required this.$class, this.stats = const []});

  final Class $class;
  final List<Stat> stats;

  List<Stat> get allStats => stats.followedBy($class.stats).toList();
}

final class Class extends PikaResource {
  Class({required super.id, required super.name, this.stats = const []});

  final List<Stat> stats;
}

final class Stat extends PikaResource {
  Stat({required super.id, required super.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  final StatType type;
  final int? min;
  final int? max;
  final List<String>? enumValues;
}

enum StatType { boolean, integerRange, orderedEnum }
