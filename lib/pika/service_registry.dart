import 'package:alwan/api/api_client.dart';
import 'package:get_it/get_it.dart';

import 'data/game_repo.dart';
import 'domain/i_game_repo.dart';

extension GetItPikaRegistery on GetIt {
  void registerPika() {
    registerFactory<IGameRepo>(() => GameRepo(get<ApiClient>()));
  }
}
