import 'package:alwan/api/dto.dart';

import '../domain/game_models.dart';

final class GameProgressDtoConverter {
  GameProgressDto build(Game game, String userId) {
    return GameProgressDto(
      userId: userId,
      game: game.id.toString(),
      completed: game.progress.done.value,
      achievementProgress: game.achievements.map(_buildAchievementProgressDto).nonNulls.toList(),
    );
  }

  AchievementProgressDto? _buildAchievementProgressDto(Achievement achievement) {
    var objectiveProgList = achievement.objectives.map(_buildObjectiveProgressDto).nonNulls.toList();
    var entityDoneList = achievement.progress.entitiesDone.map((id) => id.toString()).toList();
    if (objectiveProgList.isEmpty && achievement.progress.done.value == false && entityDoneList.isEmpty) return null;
    return AchievementProgressDto(
      achievement: achievement.id.toString(),
      completed: achievement.progress.done.value,
      objectiveProgress: objectiveProgList,
      entitiesDone: entityDoneList,
    );
  }

  ObjectiveProgressDto? _buildObjectiveProgressDto(Objective objective) {
    var entityDoneList = objective.progress.entitiesDone.map((id) => id.toString()).toList();
    if (objective.progress.done.value == false && entityDoneList.isEmpty) return null;
    return ObjectiveProgressDto(
      objective: objective.id.toString(),
      completed: objective.progress.done.value,
      entitiesDone: entityDoneList,
    );
  }
}
