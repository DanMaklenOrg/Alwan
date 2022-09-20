import 'package:alwan/api/pika_client.dart';
import 'package:alwan/auth/auth_context_provider.dart';
import 'package:alwan/config.dart';

import 'api/ana_client.dart';

class Services {
  static final PikaClient pikaClient = PikaClient(host: Config.getValue('clientHost'), port: Config.getValue('pikaClientPort'));
  static final AnaClient anaClient = AnaClient(host: Config.getValue('clientHost'), port: Config.getValue('anaClientPort'));
  static final AuthContextProvider authContextProvider = AuthContextProvider();
}
