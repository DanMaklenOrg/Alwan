import 'package:alwan/pika/game_models.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:flutter/material.dart';

class PikaFilterState extends ChangeNotifier {
  final ValueNotifier<bool> hideCompletedEntities = ValueNotifier(true);

  List<Entity> filterEntity(List<Entity> entityList, UserStats userStats) {
    return entityList.where((e) {
      if (hideCompletedEntities.value && userStats.isEntityCompleted(e)) return false;
      return true;
    }).toList();
  }

  List<Achievement> filterAchievement(List<Achievement> achievementList, UserStats userStats) {
    return achievementList.where((p) {
      return true;
    }).toList();
  }
}
