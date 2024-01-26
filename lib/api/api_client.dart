import 'package:alwan/api/dto.dart';
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
}
