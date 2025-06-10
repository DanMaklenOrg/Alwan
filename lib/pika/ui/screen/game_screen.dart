import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../domain/game_models.dart';
import '../../domain/game_progress_models.dart';
import '../../domain/i_game_progress_repo.dart';
import '../../domain/i_game_repo.dart';

typedef _PikaData = ({Game game, GameProgress gameProgress});

final class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<({Game game, GameProgress gameProgress})>(
      fetcher: _fetchData,
      builder: (context, data) => MultiProvider(
        providers: [
          Provider(create: (_) => data.game),
          ChangeNotifierProvider(create: (_) => data.gameProgress),
          ChangeNotifierProvider(create: (_) => data.gameProgress),
        ],
        child: BaseScreenLayout(
          title: data.game.name,
          body: Container(), // const PikaGameView(),
        ),
      ),
    );
  }

  Future<({Game game, GameProgress gameProgress})> _fetchData() async {
    var game = await serviceProvider.get<IGameRepo>().getGame(widget.gameId);
    var gameProgress = await serviceProvider.get<IGameProgressRepo>().getGameProgress(widget.gameId);
    return (game: game, gameProgress: gameProgress);
  }
}
