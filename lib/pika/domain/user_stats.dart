import 'package:flutter/foundation.dart';

import 'game_models.dart';

class UserStats extends ChangeNotifier {
  UserStats(this.rootGameId, List<GameProgress> userStats)
      : _rawDict = {};


  final String rootGameId;
  final Map<(ResourceId, ResourceId), String> _rawDict;


  Iterable<GameProgress> getEntityStatList() => _rawDict.entries.map((e) => GameProgress());
}

class GameProgress with ChangeNotifier {
  GameProgress();
}
