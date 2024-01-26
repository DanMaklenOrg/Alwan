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

  void login(String t) {
    token = t;
    notifyListeners();
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
