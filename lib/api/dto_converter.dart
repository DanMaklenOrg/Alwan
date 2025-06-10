import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/user_stats.dart';

import '../pika/game_models.dart';

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
      criterionCategory: dto.criterionCategory == null ? null : ResourceId(id: dto.criterionCategory!),
    );
  }

  Objective fromObjectiveDto(ObjectiveDto dto) {
    return Objective(
      id: ResourceId(id: dto.id),
      name: dto.name,
      criterionCategory: dto.criterionCategory == null ? null : ResourceId(id: dto.criterionCategory!),
      description: dto.description,
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
