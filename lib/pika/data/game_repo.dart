import 'package:alwan/api/api_client.dart';
import 'package:alwan/service_provider.dart';

import '../domain/game_models.dart';
import '../domain/i_game_repo.dart';
import 'dto_converter.dart';

sealed class GameRepo implements IGameRepo {
  final ApiClient client = serviceProvider.get<ApiClient>();

  @override
  Future<Game> getGame(String gameId) async {
    var dto = await client.getGame(gameId);
    return DtoConverter().fromGameDto(dto);
  }
}
