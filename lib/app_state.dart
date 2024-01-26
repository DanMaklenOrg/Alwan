import 'package:flutter/material.dart';

final class AppState extends ChangeNotifier {
  AppState() {
    auth.addListener(notifyListeners);
  }

  final auth = AuthState();
}

final class AuthState extends ChangeNotifier {
  String? token;

  bool get isLoggedIn => token != null;

  void login(String token) {
    token = token;
    notifyListeners();
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
