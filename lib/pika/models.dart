import 'package:alwan/pika/pika_context.dart';

final class Domain {
  Domain({
    required this.id,
    required this.name,
    this.stats = const {},
    this.entities = const [],
    this.subDomains = const [],
    this.projects = const [],
  });

  final String id;
  final String name;
  final Map<ResourceId, Stat> stats;
  final List<Entity> entities;
  final List<Project> projects;
  final List<Domain> subDomains;
}

final class Project {
  Project({required this.id, required this.name});

  final ResourceId id;
  final String name;

  bool isCompleted(PikaContext context) => context.userStats.isProjectCompleted(this);

  @override
  String toString() => id.toString();
}

final class Entity {
  Entity({required this.id, required this.name, required this.stats});

  final ResourceId id;
  final String name;
  final List<ResourceId> stats;

  bool isCompleted(PikaContext context) {
    return stats.every((sid) {
      var stat = context.getStat(sid);
      var statValue = context.userStats.getStatValue(this, stat);
      return stat.isCompleted(statValue);
    });
  }

  @override
  String toString() => id.toString();
}

final class Stat {
  Stat({required this.id, required this.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  final ResourceId id;
  final String name;
  final StatType type;
  final int? min;
  final int? max;
  final List<String>? enumValues;

  bool isCompleted(String? val) => switch (type) {
        StatType.boolean => val == "true",
        StatType.integerRange => val != null && int.parse(val) == max || min == max,
        StatType.orderedEnum => val == enumValues!.last,
      };

  @override
  String toString() => id.toString();
}

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

enum StatType { boolean, integerRange, orderedEnum }
