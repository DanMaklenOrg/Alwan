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

final class GameSummaryDto {
  GameSummaryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        version = json['version'] as String;

  final String id;
  final String name;
  final String version;
}

final class GameDto {
  GameDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        version = json['version'] as String,
        entities = (json['entities'] as List).map((e) => EntityDto.fromJson(e)).toList();

  final String id;
  final String name;
  final String version;
  final List<EntityDto> entities;
}

final class EntityDto {
  EntityDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        stats = (json['stats'] as List).map((e) => EntityStatsDto.fromJson(e)).toList();

  final String id;
  final String name;
  final List<EntityStatsDto> stats;
}

final class EntityStatsDto {
  EntityStatsDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = StatTypeEnumDto.fromString(json['type']),
        min = json['min'],
        max = json['max'];

  final String id;
  final String name;
  final StatTypeEnumDto type;
  final int? min;
  final int? max;
}

enum StatTypeEnumDto {
  boolean,
  integerRange;

  factory StatTypeEnumDto.fromString(String str) {
    return switch (str) {
      "Boolean" => StatTypeEnumDto.boolean,
      "IntegerRange" => StatTypeEnumDto.integerRange,
      _ => throw RangeError("Unable to convert $str to StatTypeEnumDto")
    };
  }
}
