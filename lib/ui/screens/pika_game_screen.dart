import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:flutter/material.dart';

final class PikaGameScreen extends StatelessWidget {
  const PikaGameScreen({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<GameDto>(
      fetcher: () async => (await serviceProvider.get<ApiClient>().getAllGames())[0],
      builder: (context, game) => BaseScreenLayout(
        title: game.name,
        body: Text(game.version),
      ),
    );
  }
}
