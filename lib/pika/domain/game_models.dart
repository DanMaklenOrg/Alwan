import 'package:flutter/foundation.dart';

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

final class Game extends PikaResource with ChangeNotifier {
  Game({required super.id, required super.name, required this.achievements, this.categories = const [], this.entities = const [], required this.progress}) {
    progress.addListener(notifyListeners);
    achievements.forEach((a) => a.addListener(notifyListeners));
  }

  final List<Achievement> achievements;
  final List<Category> categories;
  final List<Entity> entities;

  PikaProgress progress;

  List<Entity> entitiesByCategoryId(ResourceId categoryId) => entities.where((e) => e.category == categoryId).toList();
}

final class Achievement extends PikaResource with ChangeNotifier {
  Achievement({required super.id, required super.name, this.description, this.objectives = const [], this.criteriaCategory, required this.progress}) {
    progress.addListener(notifyListeners);
    objectives.forEach((a) => a.addListener(notifyListeners));
  }

  final String? description;
  final List<Objective> objectives;
  final ResourceId? criteriaCategory;

  PikaProgress progress;
}

final class Objective extends PikaResource with ChangeNotifier {
  Objective({required super.id, required super.name, this.description, this.criteriaCategory, required this.progress}) {
    progress.addListener(notifyListeners);
  }

  final String? description;
  final ResourceId? criteriaCategory;

  PikaProgress progress;
}

final class Category extends PikaResource {
  Category({required super.id, required super.name});
}

final class Entity extends PikaResource {
  Entity({required super.id, required super.name, required this.category});

  final ResourceId category;
}

final class PikaProgress with ChangeNotifier {
  PikaProgress({required bool done, Set<ResourceId> entitiesDone = const {}, required this.targetCount})
      : done = ValueNotifier(done),
        _entitiesDone = entitiesDone {
    this.done.addListener(notifyListeners);
  }

  final int targetCount;
  final Set<ResourceId> _entitiesDone;
  ValueNotifier<bool> done;

  List<ResourceId> get entitiesDone => _entitiesDone.toList();

  bool isEntityDone(Entity e) {
    return _entitiesDone.contains(e.id);
  }

  void setEntityAsDone(Entity e) {
    _entitiesDone.add(e.id);
    done.value = false;
    notifyListeners();
  }

  void setEntityAsNotDone(Entity e) {
    _entitiesDone.remove(e.id);
    notifyListeners();
  }
}
