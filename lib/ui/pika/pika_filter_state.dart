import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:flutter/material.dart';

class PikaFilterState extends ChangeNotifier {
  PikaFilterState() {
    domainId.addListener(notifyListeners);
  }

  final ValueNotifier<bool> hideCompletedEntities = ValueNotifier(true);
  final ValueNotifier<String?> domainId = ValueNotifier(null);

  List<Entity> filterEntity(List<Entity> entityList, UserStats userStats) {
    return entityList.where((e) {
      if (domainId.value != null && e.id.domainId != domainId.value) return false;
      if (hideCompletedEntities.value && userStats.isEntityCompleted(e)) return false;
      return true;
    }).toList();
  }

  List<Project> filterProject(List<Project> projectList, UserStats userStats) {
    return projectList.where((p) {
      if (domainId.value != null && p.id.domainId != domainId.value) return false;
      return true;
    }).toList();
  }
}
