import 'game_progress_models.dart';

abstract interface class IGameProgressRepo {
  Future<GameProgress> getGameProgress(String gameId);
}
