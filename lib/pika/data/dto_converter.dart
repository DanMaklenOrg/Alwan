import 'package:alwan/api/dto.dart';

import '../domain/game_models.dart';
import '../domain/game_progress_models.dart';

class DtoConverter {
  Game fromGameDto(GameDto game) {
    return Game(
      id: ResourceId(id: game.id),
      name: game.name,
      achievements: game.achievements.map(fromAchievementDto).toList(),
      categories: game.categories?.map(fromCategoryDto).toList() ?? [],
      entities: game.entities?.map(fromEntityDto).toList() ?? [],
    );
  }

  Achievement fromAchievementDto(AchievementDto dto) {
    return Achievement(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      objectives: dto.objectives?.map(fromObjectiveDto).toList() ?? [],
      criteriaCategory: dto.criteriaCategory == null ? null : ResourceId(id: dto.criteriaCategory!),
    );
  }

  Objective fromObjectiveDto(ObjectiveDto dto) {
    return Objective(
      id: ResourceId(id: dto.id),
      name: dto.name,
      description: dto.description,
      criteriaCategory: dto.criteriaCategory == null ? null : ResourceId(id: dto.criteriaCategory!),
    );
  }

  Category fromCategoryDto(CategoryDto dto) {
    return Category(id: ResourceId(id: dto.id), name: dto.name);
  }

  Entity fromEntityDto(EntityDto dto) {
    return Entity(
      id: ResourceId(id: dto.id),
      name: dto.name,
      category: ResourceId(id: dto.category),
    );
  }

  GameProgress fromGameProgressDto(GameProgressDto dto) {
    return GameProgress();
  }

  GameProgressDto toEntityUserStatDto(GameProgress gameProgress) {
    return GameProgressDto(
      userId: '',
      achievementProgress: [],
      completed: false,
      game: '',
    );
  }
}
