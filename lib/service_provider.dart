import 'package:alwan/api/api_client.dart';
import 'package:alwan/config/config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var serviceProvider = GetIt.instance;

final class ServiceCollection {
  static void registerServices(){
    serviceProvider.registerSingleton<Config>(const Config.fromEnv());

    final dio = serviceProvider.registerSingleton<Dio>(Dio());
    serviceProvider.registerSingleton(ApiClient(dio));
  }
}
