abstract class Resource {
  Resource({required this.id});

  final ResourceId id;
}

abstract class NamedResource extends Resource {
  NamedResource({required super.id, required this.name});

  final String name;
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
  Project({required super.id, required super.name});

  @override
  String toString() => id.toString();
}

final class Entity extends NamedResource {
  Entity({required super.id, required super.name, List<Stat> stats = const [], this.classes = const []}) : _stats = stats;

  final List<Stat> _stats;
  final List<Class> classes;

  List<Stat> get stats => [..._stats, ...classes.expand((c) => c.stats)];

  @override
  String toString() => id.toString();
}

final class Class extends Resource {
  Class({required super.id, required this.stats});

  final List<Stat> stats;

  @override
  String toString() => id.toString();
}

final class Stat extends NamedResource {
  Stat({required super.id, required super.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  final StatType type;
  final int? min;
  final int? max;
  final List<String>? enumValues;

  @override
  String toString() => id.toString();
}

enum StatType { boolean, integerRange, orderedEnum }

final class ResourceId {
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
}
