import 'dart:async';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'service_provider.dart';
import 'ui/screens/home_screen.dart';
import 'ui/pika/pika_domain_screen.dart';
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
      GoRoute(path: ':domainId', builder: (_, state) => PikaDomainScreen(domainId: state.pathParameters["domainId"]!)),
    ])
  ])
];

FutureOr<String?> _redirect(context, state) {
  final appState = serviceProvider.get<AppState>();
  if (!appState.auth.isLoggedIn) return '/sign-in';
  if (state.matchedLocation == '/sign-in') return '/';
  return null;
}
