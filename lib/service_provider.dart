import 'package:alwan/api/api_client.dart';
import 'package:alwan/app_state.dart';
import 'package:alwan/config/config.dart';
import 'package:alwan/pika/service_registry.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var serviceProvider = GetIt.instance;

final class ServiceCollection {
  static void registerServices() {
    final config = serviceProvider.registerSingleton<Config>(const Config.fromEnv());
    serviceProvider.registerSingleton<Dio>(_resolveDio(config));
    serviceProvider.registerSingleton<ApiClient>(ApiClient(serviceProvider.get<Dio>()));
    serviceProvider.registerSingleton<AppState>(AppState());
    serviceProvider.registerPika();
  }

  static Dio _resolveDio(Config config) {
    var dio = Dio();
    dio.options.baseUrl = config.baseUrl;
    return dio;
  }
}
