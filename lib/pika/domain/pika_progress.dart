import 'package:alwan/extensions/flutter_extensions.dart';
import 'package:flutter/foundation.dart';

import 'game_models.dart';

final class PikaProgress {
  PikaProgress({this.manual, this.dependents, this.criteria})
      : assert(manual == null && (dependents != null || criteria != null)),
        assert(manual != null && dependents == null && criteria == null) {}

  final ManualProgress? manual;
  final DependencyProgress? dependents;
  final CriteriaProgress? criteria;

  ProgressSummary get summary => ProgressSummary.fromSubProgress([manual?.summary, dependents?.summary, criteria?.summary].nonNulls.toList());

  bool get isCompleted => summary.isCompleted;

  bool get isManual => manual != null;
}

final class ManualProgress {
  ManualProgress({this.done = false});

  bool done;

  ProgressSummary get summary => ProgressSummary(current: done.toInt(), target: 1);

  void setAsDone() => done = true;

  void setAsNotDone() => done = false;

  void toggle() => done = !done;
}

// Assumes it's a tree-like. This logic might break if there are cycles.
final class DependencyProgress {
  DependencyProgress({required Set<PikaProgress> dependents}) : _dependents = dependents;

  final Set<PikaProgress> _dependents;

  ProgressSummary get summary => ProgressSummary(current: _dependents.where((c) => c.summary.isCompleted).length, target: _dependents.length);
}

final class CriteriaProgress with ChangeNotifier {
  CriteriaProgress({required int targetCount, required Set<ResourceId> entitiesDone})
      : _entitiesDone = entitiesDone,
        _targetCount = targetCount;

  final Set<ResourceId> _entitiesDone;
  final int _targetCount;

  ProgressSummary get summary => ProgressSummary(current: _entitiesDone.length, target: _targetCount);

  List<ResourceId> get entitiesDone => _entitiesDone.toList();

  bool isEntityDone(Entity e) => _entitiesDone.contains(e.id);

  void setEntityAsDone(Entity e) {
    _entitiesDone.add(e.id);
    notifyListeners();
  }

  void setEntityAsNotDone(Entity e) {
    _entitiesDone.remove(e.id);
    notifyListeners();
  }

  void setAllEntitiesAsDone(List<Entity> entities) {
    _entitiesDone.addAll(entities.map((e) => e.id));
    notifyListeners();
  }
}

final class ProgressSummary {
  ProgressSummary({required this.current, required this.target});

  ProgressSummary.fromSubProgress(List<ProgressSummary> progressList)
      : assert(progressList.isNotEmpty),
        target = progressList.fold(0, (prev, prog) => prev + prog.target),
        current = progressList.fold(0, (prev, prog) => prev + prog.current);

  final int target;
  final int current;

  int get percent => (100 * current / target).floor();

  bool get isCompleted => target == current;
}
