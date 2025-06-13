import 'package:alwan/api/dto.dart';
import 'package:collection/collection.dart';

import '../domain/game_models.dart';
import '../domain/pika_progress.dart';

final class GameBuilderFromDto {
  GameBuilderFromDto(this.gameDto, this.gameProgressDto) {
    // TODO: implement GameBuilderFromDto
    _entities = gameDto.entities?.map(_buildEntity).toList() ?? [];
    _entitiesByCategory = groupBy(_entities, (e) => e.id.toString());
    _categories = {for (var c in gameDto.categories ?? []) c.id: _buildCategory(c)};
  }

  final GameDto gameDto;
  final GameProgressDto gameProgressDto;
  late final List<Entity> _entities;
  late final Map<String, List<Entity>> _entitiesByCategory;
  late final Map<String, Category> _categories;

  Game build() {
    var achievementProgressMap = {for (var a in gameProgressDto.achievementProgress) a.achievement: a};
    var achievements = gameDto.achievements.map((a) => _buildAchievement(a, achievementProgressMap[a.id])).toList();
    return Game(
      id: ResourceId(id: gameDto.id),
      name: gameDto.name,
      achievements: achievements,
      categories: _categories.values.toList(),
      entities: _entities,
      progress: PikaProgress(
        manual: achievements.isEmpty ? _buildManualProgress(gameProgressDto.completed) : null,
        dependents: achievements.isNotEmpty ? _buildDependencyProgress(achievements.map((o) => o.progress).toList()) : null,
      ),
    );
  }

  Achievement _buildAchievement(AchievementDto dto, AchievementProgressDto? progressDto) {
    var objProgressMap = {for (var o in progressDto?.objectiveProgress ?? []) o.objective: o};
    var objectives = dto.objectives?.map((o) => _buildObjective(o, objProgressMap[o.id])).toList() ?? [];
    return Achievement(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      objectives: objectives,
      criteriaCategory: dto.criteriaCategory == null ? null : _categories[dto.criteriaCategory],
      progress: PikaProgress(
        manual: dto.criteriaCategory == null && objectives.isEmpty ? _buildManualProgress(progressDto?.completed) : null,
        dependents: objectives.isNotEmpty ? _buildDependencyProgress(objectives.map((o) => o.progress).toList()) : null,
        criteria: dto.criteriaCategory != null ? _buildCriteriaProgress(dto.criteriaCategory!, progressDto?.entitiesDone) : null,
      ),
    );
  }

  Objective _buildObjective(ObjectiveDto dto, ObjectiveProgressDto? progressDto) {
    return Objective(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      criteriaCategory: dto.criteriaCategory == null ? null : _categories[dto.criteriaCategory],
      progress: PikaProgress(
        manual: dto.criteriaCategory == null ? _buildManualProgress(progressDto?.completed) : null,
        criteria: dto.criteriaCategory != null ? _buildCriteriaProgress(dto.criteriaCategory!, progressDto?.entitiesDone) : null,
      ),
    );
  }

  Category _buildCategory(CategoryDto dto) {
    return Category(id: ResourceId(id: dto.id), name: dto.name, entities: _entitiesByCategory[dto.id]!);
  }

  Entity _buildEntity(EntityDto dto) {
    return Entity(
      id: ResourceId(id: dto.id),
      name: dto.name,
      category: ResourceId(id: dto.category),
    );
  }

  ManualProgress _buildManualProgress(bool? done) {
    return ManualProgress(done: done ?? false);
  }

  DependencyProgress _buildDependencyProgress(List<PikaProgress>? dependents) {
    return DependencyProgress(dependents: dependents?.toSet() ?? {});
  }

  CriteriaProgress _buildCriteriaProgress(String criteriaCategory, List<String>? entitiesDone) {
    return CriteriaProgress(
      targetCount: _categories[criteriaCategory]!.entities.length,
      entitiesDone: entitiesDone?.map((id) => ResourceId(id: id)).toSet() ?? {},
    );
  }
}
