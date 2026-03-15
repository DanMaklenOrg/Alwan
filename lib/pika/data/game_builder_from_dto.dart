import 'package:alwan/api/dto.dart';
import 'package:collection/collection.dart';

import '../domain/game_models.dart';
import '../domain/pika_progress.dart';

final class GameBuilderFromDto {
  GameBuilderFromDto(this.gameDto, this.gameProgressDto) {
    _tags = {for (var t in gameDto.tags ?? []) t.id: _buildTag(t)};
    _entities = gameDto.entities?.map(_buildEntity).toList() ?? [];
    _entitiesByCategory = groupBy(_entities, (e) => e.category.toString());
    _categories = {for (var c in gameDto.categories ?? []) c.id: _buildCategory(c)};
  }

  final GameDto gameDto;
  final GameProgressDto gameProgressDto;

  late final Map<String, Tag> _tags;
  late final List<Entity> _entities;
  late final Map<String, List<Entity>> _entitiesByCategory;
  late final Map<String, Category> _categories;

  Game build() {
    var achievementProgressMap = {for (var a in gameProgressDto.achievementProgress) a.achievement: a};
    var achievements = gameDto.achievements?.map((a) => _buildAchievement(a, achievementProgressMap[a.id])).toList() ?? [];
    return Game(
      id: ResourceId(id: gameDto.id),
      name: gameDto.name,
      achievements: achievements,
      categories: _categories.values.toList(),
      entities: _entities,
      tags: _tags.values.toList(),
      progress: PikaProgress(
        manual: achievements.isEmpty ? _buildManualProgress(gameProgressDto.completed) : null,
        dependents: achievements.isNotEmpty ? _buildDependencyProgress(achievements.map((o) => o.progress).toList()) : null,
      ),
    );
  }

  Achievement _buildAchievement(AchievementDto dto, AchievementProgressDto? progressDto) {
    var objProgressMap = {for (var o in progressDto?.objectiveProgress ?? []) o.objective: o};
    var objectives = dto.objectives?.map((o) => _buildObjective(o, objProgressMap[o.id])).toList() ?? [];
    var criterion = dto.criterion == null ? null : _buildCriterion(dto.criterion!);
    return Achievement(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      objectives: objectives,
      criterion: criterion,
      progress: PikaProgress(
        manual: criterion == null && objectives.isEmpty ? _buildManualProgress(progressDto?.completed) : null,
        dependents: objectives.isNotEmpty ? _buildDependencyProgress(objectives.map((o) => o.progress).toList()) : null,
        criteria: criterion != null ? _buildCriteriaProgress(criterion, progressDto?.entitiesDone) : null,
      ),
    );
  }

  Objective _buildObjective(ObjectiveDto dto, ObjectiveProgressDto? progressDto) {
    var criterion = dto.criterion == null ? null : _buildCriterion(dto.criterion!);
    return Objective(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      criterion: criterion,
      progress: PikaProgress(
        manual: criterion == null ? _buildManualProgress(progressDto?.completed) : null,
        criteria: criterion != null ? _buildCriteriaProgress(criterion, progressDto?.entitiesDone) : null,
      ),
    );
  }

  Criterion _buildCriterion(CriterionDto dto) {
    return Criterion(
      category: _categories[dto.category]!,
      tags: dto.tags?.map((t) => _tags[t]!).toSet() ?? {},
    );
  }

  Category _buildCategory(CategoryDto dto) {
    return Category(id: ResourceId(id: dto.id), name: dto.name, entities: _entitiesByCategory[dto.id]!);
  }

  Tag _buildTag(TagDto dto) {
    return Tag(id: ResourceId(id: dto.id), name: dto.name);
  }

  Entity _buildEntity(EntityDto dto) {
    return Entity(
      id: ResourceId(id: dto.id),
      name: dto.name,
      category: ResourceId(id: dto.category),
      tags: dto.tags?.map((t) => _tags[t]!).toSet() ?? {},
    );
  }

  ManualProgress _buildManualProgress(bool? done) {
    return ManualProgress(done: done ?? false);
  }

  DependencyProgress _buildDependencyProgress(List<PikaProgress>? dependents) {
    return DependencyProgress(dependents: dependents?.toSet() ?? {});
  }

  CriteriaProgress _buildCriteriaProgress(Criterion criterion, List<String>? entitiesDone) {
    return CriteriaProgress(
      targetCount: criterion.entities.length,
      entitiesDone: entitiesDone?.map((id) => ResourceId(id: id)).toSet() ?? {},
    );
  }
}
