import 'package:alwan/api/api_client.dart';

import '../domain/game_progress_models.dart';
import '../domain/i_game_progress_repo.dart';
import 'dto_converter.dart';

final class GameProgressRepo implements IGameProgressRepo {
  GameProgressRepo(this.client);

  final ApiClient client;

  @override
  Future<GameProgress> getGameProgress(String gameId) async {
    var dto = await client.getGameProgress(gameId);
    return DtoConverter().fromGameProgressDto(dto);
  }
}
