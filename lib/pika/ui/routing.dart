import 'package:go_router/go_router.dart';

import 'game_screen.dart';
import 'pika_home_screen.dart';

var pikaRoutes = [
  GoRoute(path: 'pika', builder: (_, __) => const PikaHomeScreen(), routes: [
    GoRoute(path: ':gameId', builder: (_, state) => GameScreen(gameId: state.pathParameters["gameId"]!)),
  ]),
];
