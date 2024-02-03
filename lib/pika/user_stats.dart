import 'package:flutter/foundation.dart';

import 'models.dart';

class UserStats extends ChangeNotifier {
  UserStats(this._rawDict, this._completedProject);

  final Map<(ResourceId, ResourceId), String> _rawDict;

  final Set<ResourceId> _completedProject;

  setStatValue(Entity entity, Stat stat, String val) {
    _rawDict[(entity.id, stat.id)] = val;
    notifyListeners();
  }

  String? getStatValue(Entity entity, Stat stat) {
    return _rawDict[(entity.id, stat.id)];
  }

  bool isProjectCompleted(Project project) => _completedProject.contains(project.id);

  void setProjectCompletionState(Project project, bool newState) {
    if (newState) {
      _completedProject.add(project.id);
    } else {
      _completedProject.remove(project.id);
    }
    notifyListeners();
  }

  Iterable<UserEntityStat> get entityStatList => _rawDict.entries.map((e) => UserEntityStat(entityId: e.key.$1, statId: e.key.$2, value: e.value));

  Set<ResourceId> get completedProjects => _completedProject;
}

class UserEntityStat {
  UserEntityStat({required this.entityId, required this.statId, required this.value});

  ResourceId entityId;
  ResourceId statId;
  String value;
}
