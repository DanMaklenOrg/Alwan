import 'package:alwan/pika/domain/pika_progress.dart';

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
  Game({
    required super.id,
    required super.name,
    required this.achievements,
    this.categories = const [],
    this.tags = const [],
    this.entities = const [],
    required this.progress,
  });

  final List<Achievement> achievements;
  final List<Category> categories;
  final List<Tag> tags;
  final List<Entity> entities;

  PikaProgress progress;
}

final class Achievement extends PikaResource {
  Achievement({required super.id, required super.name, this.description, this.objectives = const [], this.criteriaCategory, required this.progress});

  final String? description;
  final List<Objective> objectives;
  final Category? criteriaCategory;

  PikaProgress progress;
}

final class Objective extends PikaResource {
  Objective({required super.id, required super.name, this.description, this.criteriaCategory, required this.progress});

  final String? description;
  final Category? criteriaCategory;

  PikaProgress progress;
}

final class Category extends PikaResource {
  Category({required super.id, required super.name, required this.entities});

  final List<Entity> entities;
}

final class Tag extends PikaResource {
  Tag({required super.id, required super.name});
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, required this.category, required this.tags});

  final ResourceId category;
  final List<Tag> tags;
}
