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
              _Header(onSave: () => _saveGameProgress(game)),
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

  Future _saveGameProgress(Game game) async {
    return await serviceProvider.get<IGameRepo>().saveGameProgress(game);
  }
}

final class _Header extends StatelessWidget {
  const _Header({required this.onSave});

  final AsyncVoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHideCompletedCheckbox(context),
        const Spacer(),
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: onSave),
      ],
    );
  }

  Widget _buildHideCompletedCheckbox(BuildContext context) {
    var filterState = context.watch<PikaUiState>();
    return SizedBox(
      width: 175,
      child: CheckboxListTile(
        title: const Text("Hide Completed"),
        value: filterState.hideCompleted.value,
        onChanged: (value) => filterState.hideCompleted.value = value ?? false,
      ),
    );
  }
}
