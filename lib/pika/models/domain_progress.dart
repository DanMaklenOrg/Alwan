import 'dart:collection';

import 'package:alwan/pika/models/achievement.dart';
import 'package:alwan/pika/models/domain.dart';

class DomainProgress {
  DomainProgress(this.domain, {List<Achievement> unlockedAchievement = const []}) :
        _unlockedAchievementIds = HashSet.of(unlockedAchievement.map((e) => e.id));

  final Domain domain;

  final HashSet<String> _unlockedAchievementIds;

  void unlockAchievement(Achievement achievement) {
    if (!_unlockedAchievementIds.contains(achievement.id)) _unlockedAchievementIds.add(achievement.id);
  }

  void lockAchievement(Achievement achievement) {
    if (_unlockedAchievementIds.contains(achievement.id)) _unlockedAchievementIds.remove(achievement.id);
  }

  bool isAchievementUnlocked(Achievement achievement) => _unlockedAchievementIds.contains(achievement.id);
}
