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
final class DomainSummaryDto {
  DomainSummaryDto({required this.id, required this.name});

  factory DomainSummaryDto.fromJson(Map<String, dynamic> json) => _$DomainSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DomainSummaryDtoToJson(this);

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
  ProjectDto({required this.id, required this.name, required this.objectives});

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);

  final String id;
  final String name;
  final List<ObjectiveDto> objectives;
}

@JsonSerializable()
final class ObjectiveDto {
  ObjectiveDto({required this.id, required this.name, required this.requirements});

  factory ObjectiveDto.fromJson(Map<String, dynamic> json) => _$ObjectiveDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveDtoToJson(this);

  final String id;
  final String name;
  final List<ObjectiveRequirementDto> requirements;
}

@JsonSerializable()
final class ObjectiveRequirementDto {
  ObjectiveRequirementDto({required this.$class, required this.stat, required this.min});

  factory ObjectiveRequirementDto.fromJson(Map<String, dynamic> json) => _$ObjectiveRequirementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveRequirementDtoToJson(this);

  @JsonKey(name: 'class')
  final String $class;
  final String stat;
  final int min;
}

@JsonSerializable()
final class ClassDto {
  ClassDto({required this.id, required this.name, required this.attributes, required this.stats});

  factory ClassDto.fromJson(Map<String, dynamic> json) => _$ClassDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClassDtoToJson(this);

  final String id;
  final String name;
  final List<AttributeDto> attributes;
  final List<StatDto> stats;
}

@JsonSerializable()
final class EntityDto {
  EntityDto({required this.id, required this.name, required this.$class, required this.attributes, required this.stats});

  factory EntityDto.fromJson(Map<String, dynamic> json) => _$EntityDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EntityDtoToJson(this);

  final String id;
  final String name;
  @JsonKey(name: 'class')
  final String $class;
  final List<AttributeDto> attributes;
  final List<StatDto> stats;
}

@JsonSerializable()
final class AttributeDto {
  AttributeDto({required this.id, required this.value});

  factory AttributeDto.fromJson(Map<String, dynamic> json) => _$AttributeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeDtoToJson(this);

  final String id;
  final int value;
}

@JsonSerializable()
final class StatDto {
  StatDto({required this.id, required this.name, required this.type, required this.min, required this.max, required this.enumValues});

  factory StatDto.fromJson(Map<String, dynamic> json) => _$StatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StatDtoToJson(this);

  final String id;
  final String name;
  final StatTypeEnumDto type;
  final IntOrAttributeDto? min;
  final IntOrAttributeDto? max;
  final List<String>? enumValues;
}

@JsonSerializable()
final class IntOrAttributeDto {
  IntOrAttributeDto({this.constValue, this.attributeId})
    : assert(constValue != null || attributeId != null);

  factory IntOrAttributeDto.fromJson(Map<String, dynamic> json) => _$IntOrAttributeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IntOrAttributeDtoToJson(this);

  final int? constValue;
  final String? attributeId;
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum StatTypeEnumDto {
  boolean,
  integerRange,
  orderedEnum;
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
