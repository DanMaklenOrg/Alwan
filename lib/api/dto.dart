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

final class GameDto {
  GameDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        version = json['version'] as String;

  final String id;
  final String name;
  final String version;
}
