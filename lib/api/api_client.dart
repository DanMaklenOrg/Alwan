import 'package:alwan/config.dart';
import 'package:alwan/services.dart';
import 'package:flutter/material.dart';

import 'base_api_client.dart';
import 'dto/common/domain_dto.dart';
import 'dto/common/entity_dto.dart';
import 'dto/common/progress_dto.dart';
import 'dto/request/sign_in_dto.dart';
import 'dto/response/get_domain_profile_response_dto.dart';

class ApiClient {
  ApiClient.of(BuildContext context)
      : _host = Config.getValue('clientHost'),
        _pikaPort = Config.getValue('pikaClientPort'),
        _anaPort = Config.getValue('anaClientPort'),
        _context = context;

  final BaseApiClient _client = BaseApiClient();
  final BuildContext _context;
  final String _host;
  final int _pikaPort;
  final int _anaPort;

  // Auth
  Future<bool> signIn(SignInRequestDto requestDto) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.post,
      host: _host,
      port: _anaPort,
      path: 'api/auth/signin',
      body: requestDto,
      authToken: false,
    );
    var response = await _callApi(request: request, redirectToLoginOn401: false);
    var responseDto = SignInResponseDto.fromJson(response.body);
    Services.authContextProvider.signIn(responseDto.token);
    return response.statusCode == 200;
  }

  // Pika - Domain
  Future<DomainDto> addDomain(String name) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.post,
      host: _host,
      port: _pikaPort,
      path: 'api/domain',
      queryParameters: {"domainName": name},
    );
    var response = await _callApi(request: request);
    return DomainDto.fromJson(response.body);
  }

  Future<List<DomainDto>> getDomainList() async {
    var request = ApiRequest(
      httpMethod: HttpMethod.get,
      host: _host,
      port: _pikaPort,
      path: 'api/domain',
    );
    var response = await _callApi(request: request);
    return response.body.map<DomainDto>((e) => DomainDto.fromJson(e)).toList();
  }

  // Pika - Entity
  Future<List<EntityDto>> getEntityList(String domainId) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.get,
      host: _host,
      port: _pikaPort,
      path: 'api/entity',
      queryParameters: {'domainId': domainId},
    );
    var response = await _callApi(request: request);
    return response.body.map<EntityDto>((e) => EntityDto.fromJson(e)).toList();
  }

  Future<EntityDto> addEntity(String domainId, String name, String? parentId) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.post,
      host: _host,
      port: _pikaPort,
      path: 'api/entity',
      queryParameters: {
        'domainId': domainId,
        'name': name,
        if(parentId != null) 'parentId': parentId
      },
    );
    var response = await _callApi(request: request);
    return EntityDto.fromJson(response.body);
  }

  // ...
  Future<GetDomainProfileResponseDto> getDomainProfile(String domainId) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.get,
      host: _host,
      port: _pikaPort,
      path: 'api/domain/$domainId/profile',
    );
    var response = await _callApi(request: request);
    return GetDomainProfileResponseDto.fromJson(response.body);
  }

  Future putProgress(ProgressDto requestDto) async {
    var request = ApiRequest(
      httpMethod: HttpMethod.put,
      host: _host,
      port: _pikaPort,
      path: 'api/progress',
      body: requestDto,
    );
    await _callApi(request: request);
  }

  Future<ApiResponse> _callApi({
    required ApiRequest request,
    bool redirectToLoginOn401 = true,
  }) async {
    ApiResponse response;
    bool shouldRetry = false;

    do {
      shouldRetry = false;
      response = await _client.callApi(request);
      if (response.statusCode != 200) shouldRetry = await _handleResponseStatusCode(response, redirectToLoginOn401);
    } while (shouldRetry);
    return response;
  }

  Future<bool> _handleResponseStatusCode(ApiResponse response, bool redirectToLoginOn401) async {
    if (redirectToLoginOn401 && response.statusCode == 401) return await Navigator.of(_context).pushNamed('/signin') as bool;
    if (response.statusCode < 200 || response.statusCode >= 300) throw Exception("Http Status Code is not Ok. ${response.statusCode}");
    return false;
  }
}
