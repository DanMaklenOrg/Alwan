import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState() {
    auth.addListener(notifyListeners);
  }

  final auth = AuthState();
}

class AuthState extends ChangeNotifier {
  String? _token;

  bool get isLoggedIn => _token != null;

  void login(String token) {
    _token = token;
    notifyListeners();
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
