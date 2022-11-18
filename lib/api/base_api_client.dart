import 'dart:convert';

import 'package:http/http.dart';

enum HttpMethod {
  get,
  post,
  put,
}

class ApiRequest {
  ApiRequest({
    required this.httpMethod,
    required String host,
    required int port,
    required String path,
    this.body,
    this.authToken,
  }) : uri = Uri(scheme: 'https', host: host, port: port, path: path);

  HttpMethod httpMethod;
  Uri uri;
  Object? body;
  String? authToken;
}

class ApiResponse {
  ApiResponse({
    required this.statusCode,
    required this.body,
  });

  ApiResponse.fromHttpResponse(Response response)
      : statusCode = response.statusCode,
        body = response.body.isEmpty ? {} : json.decode(response.body);

  int statusCode;
  dynamic body;
}

class BaseApiClient {
  final Client _client = Client();

  Future<ApiResponse> callApi(ApiRequest request) async {
    switch (request.httpMethod) {
      case HttpMethod.get:
        return ApiResponse.fromHttpResponse(await _client.get(request.uri, headers: _headers(request)));
      case HttpMethod.post:
        return ApiResponse.fromHttpResponse(await _client.post(request.uri, body: json.encode(request.body), headers: _headers(request)));
      case HttpMethod.put:
        return ApiResponse.fromHttpResponse(await _client.put(request.uri, body: json.encode(request.body), headers: _headers(request)));
    }
  }

  Map<String, String> _headers(ApiRequest request) => {
        if (request.authToken != null) "Authorization": "Bearer ${request.authToken}",
        'Content-Type': 'application/json',
      };
}
