import 'package:alwan/api/api_client.dart';
import 'package:alwan/app_state.dart';
import 'package:alwan/config/config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var serviceProvider = GetIt.instance;

final class ServiceCollection {
  static void registerServices() {
    final config = serviceProvider.registerSingleton<Config>(const Config.fromEnv());
    final dio = serviceProvider.registerSingleton<Dio>(_resolveDio(config));
    serviceProvider.registerSingleton(ApiClient(dio));
    serviceProvider.registerSingleton<AppState>(AppState());
  }

  static Dio _resolveDio(Config config) {
    var dio = Dio();
    dio.options.baseUrl = config.baseUrl;
    return dio;
  }
}
