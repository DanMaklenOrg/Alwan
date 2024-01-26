import 'package:alwan/api/dto.dart';
import 'package:alwan/app_state.dart';
import 'package:alwan/service_provider.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<SignInResponseDto> signIn(SignInRequestDto requestDto) async {
    var response = await _dio.post('/ana/auth/sign-in', data: requestDto.toJson());
    return SignInResponseDto.fromJson(response.data);
  }

  Future<DomainDto> getDomain(String domainId) async {
    var response = await _dio.get('/pika/domain/$domainId');
    return DomainDto.fromJson(response.data);
  }

  Future<List<DomainSummaryDto>> getAllDomains() async {
    var response = await _dio.get('/pika/domain/all');
    return (response.data as List).map((e) => DomainSummaryDto.fromJson(e)).toList();
  }

  Future<UserStatsDto> getUserStat(String domainId) async {
    var token = serviceProvider.get<AppState>().auth.token;
    var response = await _dio.get(
      '/pika/domain/$domainId/stats',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );    return UserStatsDto.fromJson(response.data);
  }

  Future setUserStat(String domainId, UserStatsDto userStatsDto) async {
    var token = serviceProvider.get<AppState>().auth.token;
    var json = userStatsDto.toJson();
    await _dio.post(
      '/pika/domain/$domainId/stats',
      data: json,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
