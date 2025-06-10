import 'package:flutter/material.dart';

class PikaUiState extends ChangeNotifier {
  PikaUiState() {
    hideCompletedEntities.addListener(notifyListeners);
  }

  final ValueNotifier<bool> hideCompletedEntities = ValueNotifier(true);
}
