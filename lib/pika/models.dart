abstract class Resource implements Comparable<Resource> {
  Resource({required this.id});

  final ResourceId id;

  @override
  bool operator ==(Object other) => other is Resource && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => id.toString();

  @override
  int compareTo(Resource other) => id.compareTo(other.id);
}

abstract class NamedResource extends Resource {
  NamedResource({required super.id, required this.name});

  final String name;

  @override
  int compareTo(Resource other) {
    if (other is! NamedResource) return super.compareTo(other);
    return name.compareTo(other.name);
  }
}

final class Domain {
  Domain({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  String toString() => id.toString();
}

final class Project extends NamedResource {
  Project({required super.id, required super.name, required this.objectives});

  List<Objective> objectives;
}

final class Objective {
  Objective({required this.title, required this.requirements});

  final String title;
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

final class Entity extends NamedResource {
  Entity({required super.id, required super.name, this.stats = const [], this.classes = const []});

  final List<Stat> stats;
  final List<Class> classes;
}

final class Class extends Resource {
  Class({required super.id, this.stats = const []});

  final List<Stat> stats;
}

final class Stat extends NamedResource {
  Stat({required super.id, required super.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  final StatType type;
  final int? min;
  final int? max;
  final List<String>? enumValues;
}

enum StatType { boolean, integerRange, orderedEnum }

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
