import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/dto_converter.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/pika/pika_game_view.dart';
import 'package:alwan/ui/pika/pika_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Provider(create: (_) => _buildContainer(data)),
          ChangeNotifierProvider(create: (_) => _buildUserStats(data)),
          ChangeNotifierProvider(create: (_) => PikaFilterState()),
        ],
        child: BaseScreenLayout(
          title: data.rootGame.name,
          body: const PikaGameView(),
        ),
      ),
    );
  }

  Future<_PikaData> _fetchData() async {
    var client = serviceProvider.get<ApiClient>();
    return _PikaData(
      rootGame: await client.getGame(widget.gameId),
      userStats: await client.getUserStat(widget.gameId),
    );
  }

  PikaContainer _buildContainer(_PikaData data) {
    var builder = PikaContainerBuilder();
    builder.loadGame(data.rootGame);
    return builder.build();
  }

  UserStats _buildUserStats(_PikaData data) {
    var converter = DtoConverter();
    var entityStatsList = data.userStats.entityStats.map(converter.fromUserEntityStatDto).toList();
    return UserStats(data.rootGame.id, entityStatsList);
  }
}

class _PikaData {
  _PikaData({required this.rootGame, required this.userStats});

  final GameDto rootGame;
  final UserStatsDto userStats;
}
