import 'package:alwan/pika/domain/game_models.dart';
import 'package:alwan/pika/domain/game_progress_models.dart';
import 'package:flutter/material.dart';

class PikaFilterState extends ChangeNotifier {
  final ValueNotifier<bool> hideCompletedEntities = ValueNotifier(true);

  List<Entity> filterEntity(List<Entity> entityList, GameProgress userStats) {
    return entityList.where((e) {
      // if (hideCompletedEntities.value && userStats.isEntityCompleted(e)) return false;
      return true;
    }).toList();
  }

  List<Achievement> filterAchievement(List<Achievement> achievementList, GameProgress userStats) {
    return achievementList.where((p) {
      return true;
    }).toList();
  }
}
