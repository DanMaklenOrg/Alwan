import 'package:flutter/material.dart';

final class AppState extends ChangeNotifier {
  AppState() {
    auth.addListener(notifyListeners);
  }

  final auth = AuthState();
}

class AuthState extends ChangeNotifier {
  String? _token;

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
