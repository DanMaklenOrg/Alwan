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

final class DomainDto {
  DomainDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        projects = (json['projects'] as List).map((e) => ProjectDto.fromJson(e)).toList(),
        entities = (json['entities'] as List).map((e) => EntityDto.fromJson(e)).toList(),
        stats = (json['stats'] as List).map((e) => StatDto.fromJson(e)).toList(),
        subDomains = (json['sub_domains'] as List).map((e) => DomainDto.fromJson(e)).toList();

  final String id;
  final String name;
  final List<ProjectDto> projects;
  final List<EntityDto> entities;
  final List<StatDto> stats;
  final List<DomainDto> subDomains;
}

final class ProjectDto {
  ProjectDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  final String id;
  final String name;
}

final class EntityDto {
  EntityDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        stats = (json['stats'] as List).cast<String>();

  final String id;
  final String name;
  final List<String> stats;
}

final class StatDto {
  StatDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = StatTypeEnumDto.fromString(json['type']),
        min = json['min'],
        max = json['max'],
        enumValues = (json['enum_values'] as List?)?.cast<String>();

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

final class UserStatsDto {
  UserStatsDto({required this.entityStats, required this.completedProjectIds});

  Map<String, dynamic> toJson() =>
      {
        'entity_stats': entityStats.map((e) => e.toJson()).toList(),
        'completed_project_ids': completedProjectIds,
      };

  UserStatsDto.fromJson(Map<String, dynamic> json)
      : entityStats = (json['entity_stats'] as List).map((e) => UserEntityStatDto.fromJson(e)).toList(),
        completedProjectIds = (json['completed_project_ids'] as List).cast<String>();

  final List<UserEntityStatDto> entityStats;
  final List<String> completedProjectIds;
}

final class UserEntityStatDto {
  UserEntityStatDto({required this.entityId, required this.statId, required this.value});

  Map<String, dynamic> toJson() =>
      {
        'entity_id': entityId,
        'stat_id': statId,
        'value': value,
      };

  UserEntityStatDto.fromJson(Map<String, dynamic> json)
      : entityId = json['entity_id'],
        statId = json['stat_id'],
        value = json['value'];

  final String entityId;
  final String statId;
  final String value;
}
