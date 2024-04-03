import 'package:flutter/foundation.dart';

import 'models.dart';

class UserStats extends ChangeNotifier {
  UserStats(this.rootDomainId, List<UserEntityStat> userStats, List<ResourceId> completedProjects)
      : _rawDict = {for (var s in userStats) (s.entityId, s.statId): s.value},
        _completedProject = Set<ResourceId>.from(completedProjects);


  final String rootDomainId;
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

  bool isEntityCompleted(Entity entity){
    return entity.stats.every((s) => isEntityStatCompleted(entity, s));
  }

  bool isEntityStatCompleted(Entity e, Stat s){
    var val = getStatValue(e, s);
    return switch (s.type) {
      StatType.boolean => val == "true",
      StatType.integerRange => val != null && int.parse(val) == s.max || s.min == s.max,
      StatType.orderedEnum => val == s.enumValues!.last,
    };
  }

  Iterable<UserEntityStat> getEntityStatList() => _rawDict.entries.map((e) => UserEntityStat(entityId: e.key.$1, statId: e.key.$2, value: e.value));

  List<ResourceId> getCompletedProjectList() => _completedProject.toList();
}

class UserEntityStat {
  UserEntityStat({required this.entityId, required this.statId, required this.value});

  ResourceId entityId;
  ResourceId statId;
  String value;
}
