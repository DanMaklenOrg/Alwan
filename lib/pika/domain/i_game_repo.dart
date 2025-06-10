import 'game_models.dart';

abstract interface class IGameRepo {
  Future<Game> getGame(String gameId);
}
