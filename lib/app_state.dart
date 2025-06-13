import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
    name = JwtDecoder.decode(t)['name'];
    notifyListeners();
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
