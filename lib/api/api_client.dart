import 'package:alwan/api/dto.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<SignInResponseDto> signIn(SignInRequestDto requestDto) async {
    var response = await _dio.post('/ana/auth/sign-in', data: requestDto.toJson());
    return SignInResponseDto.fromJson(response.data);
  }

  Future<GameDto> getGame(String gameId) async {
    var response = await _dio.get('/pika/game/$gameId');
    return GameDto.fromJson(response.data);
  }

  Future<List<GameSummaryDto>> getAllGames() async {
    var response = await _dio.get('/pika/game/all');
    return (response.data as List).map((e) => GameSummaryDto.fromJson(e)).toList();
  }
}
