import 'package:alwan/api/api_client.dart';

import '../domain/game_models.dart';
import '../domain/i_game_repo.dart';
import 'dto_converter.dart';

final class GameRepo implements IGameRepo {
  GameRepo(this.client);

  final ApiClient client;

  @override
  Future<Game> getGame(String gameId) async {
    var dto = await client.getGame(gameId);
    return DtoConverter().fromGameDto(dto);
  }
}
