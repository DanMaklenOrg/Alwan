import 'package:alwan/api/pika_client.dart';
import 'package:alwan/config.dart';

class Services {
  static final PikaClient pikaClient = PikaClient(host: Config.getValue('pikaClientHost'), port: Config.getValue('pikaClientPort'));
}
