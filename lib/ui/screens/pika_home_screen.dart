import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/common/async_data_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PikaHomeScreen extends StatelessWidget {
  const PikaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
      title: 'Pika',
      body: AsyncDataBuilder<List<GameDto>>(
        fetcher: serviceProvider.get<ApiClient>().getAllGames,
        builder: _buildGrid,
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<GameDto> gameList) {
    return GridView.extent(
      maxCrossAxisExtent: 250,
      children: gameList.map((e) => _gameCard(context, e)).toList(),
    );
  }

  Widget _gameCard(BuildContext context, GameDto game) {
    return Card(
      child: GestureDetector(
        onTap: () => context.go("/pika/${game.id}"),
        child: Align(
          alignment: Alignment.center,
          child: Text(game.name, style: Theme.of(context).textTheme.headlineSmall),
        ),
      ),
    );
  }
}
