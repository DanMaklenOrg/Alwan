import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/game_models.dart';
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
      body: AsyncDataBuilder<Game>(
        fetcher: _fetchData,
        builder: (context, game) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PikaUiState()),
          ],
          child: Column(
            children: [
              _Header(),
              Expanded(child: GameWidget(game: game)),
            ],
          ),
        ),
      ),
    );
  }

  Future<Game> _fetchData() async {
    return await serviceProvider.get<IGameRepo>().getGame(gameId);
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
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: () => _saveProgress(context)),
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

  Future _saveProgress(BuildContext context) async {
    var game = context.read<Game>();
    return await serviceProvider.get<IGameRepo>().saveGameProgress(game);
  }
}
