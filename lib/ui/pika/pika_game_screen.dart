import 'package:alwan/pika/game_models.dart';
import 'package:alwan/pika/i_game_progress_repo.dart';
import 'package:alwan/pika/i_game_repo.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/pika/pika_game_view.dart';
import 'package:alwan/ui/pika/pika_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef _PikaData = ({Game game, GameProgress gameProgress});

final class PikaGameScreen extends StatefulWidget {
  const PikaGameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  State<PikaGameScreen> createState() => _PikaGameScreenState();
}

class _PikaGameScreenState extends State<PikaGameScreen> {
  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<_PikaData>(
      fetcher: _fetchData,
      builder: (context, data) => MultiProvider(
        providers: [
          Provider(create: (_) => data.game),
          ChangeNotifierProvider(create: (_) => data.gameProgress),
          ChangeNotifierProvider(create: (_) => PikaFilterState()),
        ],
        child: BaseScreenLayout(
          title: data.game.name,
          body: const PikaGameView(),
        ),
      ),
    );
  }

  Future<_PikaData> _fetchData() async {
    return (
      game: await serviceProvider.get<IGameRepo>().getGame(widget.gameId),
      gameProgress: await serviceProvider.get<IGameProgressRepo>().getGameProgress(widget.gameId),
    );
  }
}
