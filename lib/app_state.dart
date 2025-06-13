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
  String? name;

  bool get isLoggedIn => token != null;

  void login(String t) {
    token = t;
    name = JwtDecoder.decode(t)['unique_name'];
    notifyListeners();
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
