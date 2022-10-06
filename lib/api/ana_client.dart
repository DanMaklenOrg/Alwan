import 'package:alwan/api/base_http_client.dart';
import 'package:alwan/api/dto/request/sign_in_dto.dart';
import 'package:alwan/services.dart';

class AnaClient extends BaseHttpClient{
  AnaClient({
    required String host,
    required int port,
  }) : super(host: host, port: port);

  Future signIn(SignInRequestDto requestDto) async {
    var response = await post(path: 'api/auth/signin', body: requestDto);
    var responseDto = SignInResponseDto.fromJson(response);
    Services.authContextProvider.signIn(responseDto.token);
  }
}
