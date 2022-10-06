import 'dart:convert';

import 'package:alwan/services.dart';
import 'package:http/http.dart';

class BaseHttpClient {
  BaseHttpClient({
    required this.host,
    required this.port,
  }) : _client = Client();

  final Client _client;
  final String host;
  final int port;

  Uri _endpoint(String path) {
    return Uri(scheme: 'https', host: host, port: port, path: path);
  }

  Map<String, String> _headers() => {
        if (Services.authContextProvider.isSignedIn) "Authorization": "Bearer ${Services.authContextProvider.token}",
        'Content-Type': 'application/json',
      };

  void _validateResponseStatus(BaseResponse response) {
    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw Exception("Http Status Code is not Ok. ${response.statusCode}");
    }
  }

  Future<dynamic> get({required String path}) async {
    var response = await _client.get(_endpoint(path), headers: _headers());
    _validateResponseStatus(response);
    return _decodeJsonBody(response.body);
  }

  Future<dynamic> post({required String path, Object? body}) async {
    var requestBody = json.encode(body);
    var response = await _client.post(_endpoint(path), body: requestBody, headers: _headers());
    _validateResponseStatus(response);
    return _decodeJsonBody(response.body);
  }

  Future<dynamic> put({required String path, Object? body}) async {
    var requestBody = json.encode(body);
    var response = await _client.put(_endpoint(path), body: requestBody, headers: _headers());
    _validateResponseStatus(response);
    return _decodeJsonBody(response.body);
  }

  dynamic _decodeJsonBody(String body){
    if(body.isEmpty) return {};
    return json.decode(body);
  }
}
