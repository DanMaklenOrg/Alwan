import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/resource_map.dart';

import 'dto_converter.dart';
import 'models.dart';

final class PikaContainer {
  PikaContainer.empty()
      : classes = {},
        entities = {},
        achievements = [];

  late final Game game;
  final ResourceMap<Class> classes;
  final ResourceMap<Entity> entities;
  final List<Achievement> achievements;

  List<Entity> getEntitiesMatchingObjective(Objective? objective) {
    if (objective == null) return entities.toResourceList();
    var acceptedClassList = [for (var r in objective.requirements) r.$class];
    return entities.toResourceList().where((e) => acceptedClassList.contains(e.$class.id)).toList();
  }
}

final class PikaContainerBuilder {
  final PikaContainer container = PikaContainer.empty();

  late final GameDto _game;
  final List<ClassDto> _classesDto = [];
  final List<EntityDto> _entitiesDto = [];
  final List<AchievementDto> _achievementDto = [];

  void loadGame(GameDto game, {bool listGame = true}) {
    final gameList = [game];
    _classesDto.addAll(gameList.expand((d) => d.classes));
    _entitiesDto.addAll(gameList.expand((d) => d.entities));
    _achievementDto.addAll(gameList.expand((d) => d.achievements));
    _game = game;
  }

  PikaContainer build() {
    DtoConverter converter = DtoConverter(container);
    container.classes.addResourceList(_classesDto.map(converter.fromClassDto));
    container.entities.addResourceList(_entitiesDto.map(converter.fromEntityDto));
    container.achievements.addAll(_achievementDto.map(converter.fromAchievementDto));
    container.game = converter.fromGameDto(_game);
    return container;
  }
}
