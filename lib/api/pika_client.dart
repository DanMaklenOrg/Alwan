import 'package:alwan/api/dto/common/progress_dto.dart';

import 'base_http_client.dart';
import 'dto/common/domain_dto.dart';
import 'dto/response/get_domain_profile_response_dto.dart';

class PikaClient extends BaseHttpClient {
  PikaClient({
    required String host,
    required int port,
  }) : super(host: host, port: port);

  Future<List<DomainDto>> getDomainList() async {
    var response = await get(path: 'api/domain');
    return response.map<DomainDto>((e) => DomainDto.fromJson(e)).toList();
  }

  Future<GetDomainProfileResponseDto> getDomainProfile(String domainId) async {
    var response = await get(path: 'api/domain/$domainId/profile');
    return GetDomainProfileResponseDto.fromJson(response);
  }

  Future putProgress(ProgressDto progress) async {
    var request = progress.toJson();
    await put(path: 'api/progress', body: request);
  }
}
