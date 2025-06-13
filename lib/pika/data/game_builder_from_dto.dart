import 'package:alwan/api/dto.dart';
import 'package:collection/collection.dart';

import '../domain/game_models.dart';

final class GameBuilderFromDto {
  GameBuilderFromDto(this.gameDto, this.gameProgressDto)
      : entityCountByCategory = groupBy(gameDto.entities ?? <EntityDto>[], (e) => e.category).map((k, v) => MapEntry(k, v.length));

  final GameDto gameDto;
  final GameProgressDto gameProgressDto;
  final Map<String, int> entityCountByCategory;

  Game build() {
    var achievementProgressMap = {for (var a in gameProgressDto.achievementProgress) a.achievement: a};
    return Game(
      id: ResourceId(id: gameDto.id),
      name: gameDto.name,
      achievements: gameDto.achievements.map((a) => _buildAchievement(a, achievementProgressMap[a.id])).toList(),
      categories: gameDto.categories?.map(_buildCategory).toList() ?? [],
      entities: gameDto.entities?.map(_buildEntity).toList() ?? [],
      progress: _buildPikaProgress(gameProgressDto.completed),
    );
  }

  Achievement _buildAchievement(AchievementDto dto, AchievementProgressDto? progressDto) {
    var objProgressMap = {for (var o in progressDto?.objectiveProgress ?? []) o.objective: o};
    return Achievement(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      objectives: dto.objectives?.map((o) => _buildObjective(o, objProgressMap[o.id])).toList() ?? [],
      criteriaCategory: dto.criteriaCategory == null ? null : ResourceId(id: dto.criteriaCategory!),
      progress: _buildPikaProgress(progressDto?.completed, progressDto?.entitiesDone),
    );
  }

  Objective _buildObjective(ObjectiveDto dto, ObjectiveProgressDto? progressDto) {
    return Objective(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      criteriaCategory: dto.criteriaCategory == null ? null : ResourceId(id: dto.criteriaCategory!),
      progress: _buildPikaProgress(progressDto?.completed, progressDto?.entitiesDone),
    );
  }

  Category _buildCategory(CategoryDto dto) {
    return Category(id: ResourceId(id: dto.id), name: dto.name);
  }

  Entity _buildEntity(EntityDto dto) {
    return Entity(
      id: ResourceId(id: dto.id),
      name: dto.name,
      category: ResourceId(id: dto.category),
    );
  }

  PikaProgress _buildPikaProgress(bool? done, [List<String>? entitiesDone, String? criteriaCategory]) {
    return PikaProgress(
      done: done ?? false,
      entitiesDone: {for (var eid in entitiesDone ?? []) ResourceId(id: eid)},
      targetCount: criteriaCategory == null ? 0 : entityCountByCategory[criteriaCategory]!,
    );
  }
}
