import 'package:alwan/api/dto.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<SignInResponseDto> signIn(SignInRequestDto requestDto) async {
    var response = await _dio.post('/ana/auth/signIn', data: requestDto.toJson());
    return SignInResponseDto.fromJson(response.data);
  }
}
