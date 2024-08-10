import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

final class SignInRequestDto {
  const SignInRequestDto({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  final String username;
  final String password;
}

final class SignInResponseDto {
  SignInResponseDto.fromJson(Map<String, dynamic> json) : token = json['token'] as String;

  final String token;
}

final class DomainSummaryDto {
  DomainSummaryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  final String id;
  final String name;
}

@JsonSerializable()
final class DomainDto {
  DomainDto({required this.id, required this.name, required this.projects, required this.classes, required this.entities});

  factory DomainDto.fromJson(Map<String, dynamic> json) => _$DomainDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DomainDtoToJson(this);

  final String id;
  final String name;
  final List<ProjectDto> projects;
  final List<ClassDto> classes;
  final List<EntityDto> entities;
}

@JsonSerializable()
final class ProjectDto {
  ProjectDto({required this.title, required this.objectives});

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);

  final String title;
  final List<ObjectiveDto> objectives;
}

@JsonSerializable()
final class ObjectiveDto {
  ObjectiveDto({required this.title, required this.requirements});

  factory ObjectiveDto.fromJson(Map<String, dynamic> json) => _$ObjectiveDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectiveDtoToJson(this);

  final String title;
  final List<ObjectiveRequirementDto> requirements;
}

@JsonSerializable()
final class ObjectiveRequirementDto {
  ObjectiveRequirementDto({required this.$class, required this.stat, required this.min});

  factory ObjectiveRequirementDto.fromJson(Map<String, dynamic> json) => _$ObjectiveRequirementDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectiveRequirementDtoToJson(this);

  final String $class;
  final String stat;
  final int min;
}

@JsonSerializable()
final class ClassDto {
  ClassDto({required this.id, required this.stats});

  factory ClassDto.fromJson(Map<String, dynamic> json) => _$ClassDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ClassDtoToJson(this);

  final String id;
  final List<StatDto> stats;
}

@JsonSerializable()
final class EntityDto {
  EntityDto({required this.id, required this.name, required this.$class, required this.stats});

  factory EntityDto.fromJson(Map<String, dynamic> json) => _$EntityDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EntityDtoToJson(this);

  final String id;
  final String name;
  final String $class;
  final List<StatDto> stats;
}

@JsonSerializable()
final class StatDto {
  StatDto({required this.id, required this.name, required this.type, required this.min, required this.max, required this.enumValues});

  factory StatDto.fromJson(Map<String, dynamic> json) => _$StatDtoFromJson(json);
  Map<String, dynamic> toJson() => _$StatDtoToJson(this);

  final String id;
  final String name;
  final StatTypeEnumDto type;
  final int? min;
  final int? max;
  final List<String>? enumValues;
}

enum StatTypeEnumDto {
  boolean,
  integerRange,
  orderedEnum;

  factory StatTypeEnumDto.fromString(String str) {
    return switch (str) {
      "Boolean" => StatTypeEnumDto.boolean,
      "IntegerRange" => StatTypeEnumDto.integerRange,
      "OrderedEnum" => StatTypeEnumDto.orderedEnum,
      _ => throw RangeError("Unable to convert $str to StatTypeEnumDto")
    };
  }
}

@JsonSerializable()
final class UserStatsDto {
  UserStatsDto({required this.entityStats});

  factory UserStatsDto.fromJson(Map<String, dynamic> json) => _$UserStatsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatsDtoToJson(this);

  final List<UserEntityStatDto> entityStats;

}

@JsonSerializable()
final class UserEntityStatDto {
  UserEntityStatDto({required this.entityId, required this.statId, required this.value});

  factory UserEntityStatDto.fromJson(Map<String, dynamic> json) => _$UserEntityStatDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityStatDtoToJson(this);

  final String entityId;
  final String statId;
  final String value;
}
