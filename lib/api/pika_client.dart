import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dto/common/domain_dto.dart';
import 'dto/request/get_domain_profile_response_dto.dart';

class PikaClient {
  PikaClient({
    required this.host,
    required this.port,
  }) : _client = http.Client();

  final http.Client _client;
  final String host;
  final int port;

  Uri _endpoint(String path) {
    return Uri(scheme: 'https', host: host, port: port, path: path);
  }

  Future<List<DomainDto>> getDomainList() async {
    var response = await _client.get(_endpoint('api/domain'));
    var jsonObject = json.decode(response.body);
    return jsonObject.map<DomainDto>((e) => DomainDto.fromJson(e)).toList();
  }

  Future<GetDomainProfileResponseDto> getDomainProfile(String domainId) async{
    var response = await _client.get(_endpoint('api/domain/$domainId/profile'));
    var jsonObject = json.decode(response.body);
    return GetDomainProfileResponseDto.fromJson(jsonObject);
  }
}
