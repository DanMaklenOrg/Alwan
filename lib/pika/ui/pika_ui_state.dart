import 'package:flutter/material.dart';

class PikaUiState extends ChangeNotifier {
  PikaUiState() {
    hideCompleted.addListener(notifyListeners);
  }

  final ValueNotifier<bool> hideCompleted = ValueNotifier(true);
}
