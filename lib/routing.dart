import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'service_provider.dart';
import 'ui/screens/home_screen.dart';
import 'ui/pika/pika_game_screen.dart';
import 'ui/pika/pika_home_screen.dart';
import 'ui/screens/sign_in_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: _routes,
  redirect: _redirect,
  refreshListenable: serviceProvider.get<AppState>(),
);

var _routes = [
  GoRoute(path: '/', builder: (_, __) => const HomeScreen(), routes: [
    GoRoute(path: 'sign-in', builder: (_, __) => const SignInScreen()),
    GoRoute(path: 'pika', builder: (_, __) => const PikaHomeScreen(), routes: [
      GoRoute(path: ':gameId', builder: (_, state) => PikaGameScreen(gameId: state.pathParameters["gameId"]!)),
    ])
  ])
];

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
  final appState = serviceProvider.get<AppState>();
  var loc = state.matchedLocation;

  // Login
  var isLoggedIn = appState.auth.isLoggedIn;
  var isOnSignInPage = loc == '/sign-in';
  if (!isLoggedIn && !isOnSignInPage) return '/sign-in?next=$loc';
  if (isLoggedIn && isOnSignInPage) return state.uri.queryParameters['next'] ?? '/';

  // Terminate Redirect
  return null;
}
