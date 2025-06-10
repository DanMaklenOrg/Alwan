import 'package:alwan/pika/user_stats.dart';

abstract interface class IGameProgressRepo {
  Future<GameProgress> getGameProgress(String gameId);
}
