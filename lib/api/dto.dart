import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
final class SignInRequestDto {
  const SignInRequestDto({required this.username, required this.password});

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) => _$SignInRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestDtoToJson(this);

  final String username;
  final String password;
}

@JsonSerializable()
final class SignInResponseDto {
  SignInResponseDto({required this.token});

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) => _$SignInResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);

  final String token;
}

@JsonSerializable()
final class GameSummaryDto {
  GameSummaryDto({required this.id, required this.name});

  factory GameSummaryDto.fromJson(Map<String, dynamic> json) => _$GameSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameSummaryDtoToJson(this);

  final String id;
  final String name;
}

@JsonSerializable()
final class GameDto {
  GameDto({required this.id, required this.name, this.achievements, this.categories, this.tags, this.entities});

  factory GameDto.fromJson(Map<String, dynamic> json) => _$GameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameDtoToJson(this);

  final String id;
  final String name;
  final List<AchievementDto>? achievements;
  final List<CategoryDto>? categories;
  final List<TagDto>? tags;
  final List<EntityDto>? entities;
}

@JsonSerializable()
final class AchievementDto {
  AchievementDto({required this.id, required this.name, this.description, this.objectives, this.criteriaCategory});

  factory AchievementDto.fromJson(Map<String, dynamic> json) => _$AchievementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementDtoToJson(this);

  final String id;
  final String name;
  final String? description;
  final List<ObjectiveDto>? objectives;
  final String? criteriaCategory;
}

@JsonSerializable()
final class ObjectiveDto {
  ObjectiveDto({required this.id, required this.name, this.description, this.criteriaCategory});

  factory ObjectiveDto.fromJson(Map<String, dynamic> json) => _$ObjectiveDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveDtoToJson(this);

  final String id;
  final String name;
  final String? description;
  final String? criteriaCategory;}

@JsonSerializable()
final class CategoryDto {
  CategoryDto({required this.id, required this.name});

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  final String id;
  final String name;
}

@JsonSerializable()
final class TagDto {
  TagDto({required this.id, required this.name});

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TagDtoToJson(this);

  final String id;
  final String name;
}

@JsonSerializable()
final class EntityDto {
  EntityDto({required this.id, required this.name, required this.category, this.tags});

  factory EntityDto.fromJson(Map<String, dynamic> json) => _$EntityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntityDtoToJson(this);

  final String id;
  final String name;
  final String category;
  final List<String>? tags;
}

@JsonSerializable()
final class GameProgressDto {
  GameProgressDto({required this.userId, required this.game, required this.completed, required this.achievementProgress});

  factory GameProgressDto.fromJson(Map<String, dynamic> json) => _$GameProgressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameProgressDtoToJson(this);

  final String userId;
  final String game;
  final bool completed;
  final List<AchievementProgressDto> achievementProgress;
}

@JsonSerializable()
final class AchievementProgressDto {
  AchievementProgressDto({required this.achievement, required this.completed, required this.objectiveProgress, required this.entitiesDone});

  factory AchievementProgressDto.fromJson(Map<String, dynamic> json) => _$AchievementProgressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementProgressDtoToJson(this);

  final String achievement;
  final bool completed;
  final List<ObjectiveProgressDto> objectiveProgress;
  final List<String> entitiesDone;
}

@JsonSerializable()
final class ObjectiveProgressDto {
  ObjectiveProgressDto({required this.objective, required this.completed, required this.entitiesDone});

  factory ObjectiveProgressDto.fromJson(Map<String, dynamic> json) => _$ObjectiveProgressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveProgressDtoToJson(this);

  final String objective;
  final bool completed;
  final List<String> entitiesDone;
}
