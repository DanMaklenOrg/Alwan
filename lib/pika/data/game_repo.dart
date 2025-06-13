import 'package:alwan/api/api_client.dart';
import 'package:alwan/app_state.dart';
import 'package:alwan/service_provider.dart';

import '../domain/game_models.dart';
import '../domain/i_game_repo.dart';
import 'GameProgressDtoConverter.dart';
import 'game_builder_from_dto.dart';

final class GameRepo implements IGameRepo {
  GameRepo(this.client);

  final ApiClient client;

  @override
  Future<Game> getGame(String gameId) async {
    var dto = await client.getGame(gameId);
    var progressDto = await client.getGameProgress(gameId);
    return GameBuilderFromDto(dto, progressDto).build();
  }

  @override
  Future saveGameProgress(Game game) async {
    var userId = serviceProvider.get<AppState>().auth.name!;
    var gameProgressDto = GameProgressDtoConverter().build(game, userId);
    await client.setGameProgress(game.id.toString(), gameProgressDto);
  }

}
