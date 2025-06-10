import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game_models.dart';
import '../domain/game_progress_models.dart';
import '../domain/i_game_progress_repo.dart';
import '../domain/i_game_repo.dart';
import 'game_widget.dart';
import 'pika_ui_state.dart';

final class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
      title: 'Pika Game',
      body: AsyncDataBuilder<({Game game, GameProgress gameProgress})>(
        fetcher: _fetchData,
        builder: (context, data) => MultiProvider(
          providers: [
            Provider(create: (_) => data.game),
            ChangeNotifierProvider(create: (_) => data.gameProgress),
            ChangeNotifierProvider(create: (_) => PikaUiState()),
          ],
          child: Column(
            children: [
              _Header(),
              Expanded(child: GameWidget(game: data.game)),
            ],
          ),
        ),
      ),
    );
  }

  Future<({Game game, GameProgress gameProgress})> _fetchData() async {
    var game = await serviceProvider.get<IGameRepo>().getGame(gameId);
    var gameProgress = await serviceProvider.get<IGameProgressRepo>().getGameProgress(gameId);
    return (game: game, gameProgress: gameProgress);
  }
}

final class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHideCompletedCheckbox(context),
        const Spacer(),
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: _saveProgress),
      ],
    );
  }

  Widget _buildHideCompletedCheckbox(BuildContext context) {
    var filterState = context.watch<PikaUiState>();
    return SizedBox(
      width: 175,
      child: CheckboxListTile(
        title: const Text("Hide Completed"),
        value: filterState.hideCompletedEntities.value,
        onChanged: (value) => filterState.hideCompletedEntities.value = value ?? false,
      ),
    );
  }

  Future _saveProgress() async {
    // TODO: Finish Save UserStats
    // var userStats = context.read<GameProgress>();
    // var converter = DtoConverter();
    // var entityStats = userStats.getEntityStatList().map(converter.toEntityUserStatDto).toList();
    // var dto = GameProgressDto(entityStats: entityStats);
    // await serviceProvider.get<ApiClient>().setUserStat(userStats.rootGameId, dto);
  }
}
