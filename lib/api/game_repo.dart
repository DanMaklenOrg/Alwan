import 'package:alwan/api/dto_converter.dart';
import 'package:alwan/pika/i_game_repo.dart';
import 'package:alwan/pika/game_models.dart';
import 'package:alwan/service_provider.dart';

import 'api_client.dart';

sealed class GameRepo implements IGameRepo {
  final ApiClient client = serviceProvider.get<ApiClient>();

  @override
  Future<Game> getGame(String gameId) async {
    var dto = await client.getGame(gameId);
    return DtoConverter().fromGameDto(dto);
  }
}
