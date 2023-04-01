import 'package:alwan/api/dto/response/achievement_dto.dart';

class Achievement {
  Achievement.fromDto(AchievementDto dto)
      : id = dto.id,
        name = dto.name;

  final String id;
  final String name;
}
