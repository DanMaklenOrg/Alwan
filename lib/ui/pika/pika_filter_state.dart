import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:flutter/material.dart';

class PikaFilterState extends ChangeNotifier {
  PikaFilterState();

  bool _hideCompletedEntities = true;

  bool get hideCompletedEntities => _hideCompletedEntities;

  set hideCompletedEntities(bool val) {
    _hideCompletedEntities = val;
    notifyListeners();
  }

  String? _domainId;

  String? get domainId => _domainId;

  set domainId(String? val) {
    _domainId = val;
    notifyListeners();
  }

  List<Entity> filterEntity(List<Entity> entityList, UserStats userStats) {
    return entityList.where((e) {
      if (_domainId != null && e.id.domainId != _domainId) return false;
      if (_hideCompletedEntities && userStats.isEntityCompleted(e)) return false;
      return true;
    }).toList();
  }

  List<Project> filterProject(List<Project> projectList, UserStats userStats) {
    return projectList.where((p) {
      if (_domainId != null && p.id.domainId != _domainId) return false;
      if (_hideCompletedEntities && userStats.isProjectCompleted(p)) return false;
      return true;
    }).toList();
  }
}
