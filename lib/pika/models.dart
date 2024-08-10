final class ResourceId implements Comparable<ResourceId> {
  ResourceId({required this.id, required this.domainId});

  factory ResourceId.fromString(String str) {
    var segments = str.split('/');
    assert(segments.length == 2);
    return ResourceId(id: segments[1], domainId: segments[0]);
  }

  final String id;
  final String domainId;

  String get fullyQualifiedId => "$domainId/$id";

  @override
  bool operator ==(Object other) => other is ResourceId && id == other.id && domainId == other.domainId;

  @override
  int get hashCode => Object.hash(id, domainId);

  @override
  String toString() => fullyQualifiedId;

  @override
  int compareTo(ResourceId other) => fullyQualifiedId.compareTo(other.fullyQualifiedId);
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
  String toString() => id.toString();

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

  List<Class> get allRequirementClasses => requirements.map((e) => e.$class).toList();

  List<Stat> get allRequirementStats => requirements.map((e) => e.stat).toList();
}

final class ObjectiveRequirement {
  ObjectiveRequirement({required this.$class, required this.stat, required this.min});

  final Class $class;
  final Stat stat;
  final int min;
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, this.stats = const [], this.classes = const []});

  final List<Stat> stats;
  final List<Class> classes;
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
