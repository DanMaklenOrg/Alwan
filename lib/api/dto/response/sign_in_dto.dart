class SignInRequestDto {
  SignInRequestDto({
    required this.username,
    required this.password,
  });

  String username;
  String password;
}

class SignInResponseDto {
  SignInResponseDto.fromJson(Map<String, dynamic> json) : token = json['token'];

  String token;
}
