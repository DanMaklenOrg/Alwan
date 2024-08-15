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

final class Class extends PikaResource {
  Class({required super.id, required super.name, this.attributes = const [], this.stats = const []});

  final List<Attribute> attributes;
  final List<Stat> stats;
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, required this.$class, this.attributes = const [], this.stats = const []});

  final Class $class;
  final List<Attribute> attributes;
  final List<Stat> stats;

  List<Stat> get allStats => stats.followedBy($class.stats).toList();

  int getAttributeValue(ResourceId id) => attributes.followedBy($class.attributes).firstWhere((a) => a.id == id).value;
}

final class Attribute {
  Attribute({required this.id, required this.value});

  final ResourceId id;
  final int value;
}

final class Stat extends PikaResource {
  Stat({required super.id, required super.name, required this.type, this.min, this.max, this.enumValues})
      : assert(type != StatType.integerRange || (min != null && max != null)),
        assert(type != StatType.orderedEnum || (enumValues != null && enumValues.isNotEmpty));

  final StatType type;
  final IntOrAttribute? min;
  final IntOrAttribute? max;
  final List<String>? enumValues;
}

final class IntOrAttribute {
  IntOrAttribute({this.constValue, this.attributeId}) : assert(constValue != null || attributeId != null);

  final int? constValue;
  final ResourceId? attributeId;

  int getValueForEntity(Entity e) {
    if (constValue != null) return constValue!;
    return e.getAttributeValue(attributeId!);
  }
}

enum StatType { boolean, integerRange, orderedEnum }
