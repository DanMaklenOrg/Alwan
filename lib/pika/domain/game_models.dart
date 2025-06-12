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

final class Game extends PikaResource {
  Game({required super.id, required super.name, required this.achievements, this.categories = const [], this.entities = const []});

  List<Achievement> achievements;
  List<Category> categories;
  List<Entity> entities;
}

final class Achievement extends PikaResource {
  Achievement({required super.id, required super.name, this.description, this.objectives = const [], this.criteriaCategory});

  final String? description;
  final List<Objective> objectives;
  final ResourceId? criteriaCategory;
}

final class Objective extends PikaResource {
  Objective({required super.id, required super.name, this.description, this.criteriaCategory});

  final String? description;
  final ResourceId? criteriaCategory;
}

final class Category extends PikaResource {
  Category({required super.id, required super.name});
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, required this.category});

  final ResourceId category;
}
