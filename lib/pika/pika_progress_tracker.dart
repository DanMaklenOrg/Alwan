import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/pika/domain_data.dart';
import 'package:alwan/pika/pika_entry.dart';

class PikaProgressTracker {
  PikaProgressTracker(this.domain);

  final DomainData domain;
  final Map<String, Progress> _entryObjectiveProgress = {};
  final Map<PikaEntry, Progress> _filteredEntryProgress = {};

  ProjectDto? projectFilter;

  void setFilter(ProjectDto filter) {
    projectFilter = filter;
    _invalidateFilteredEntryProgress();
  }

  void clearFilter() {
    projectFilter = null;
    _invalidateFilteredEntryProgress();
  }

  void setEntryObjectiveProgress(PikaEntry entry, ObjectiveDto objective, int value) {
    _entryObjectiveProgress[_getEntryObjectiveProgressKey(entry.id, objective.id)] = Progress(progress: value, outOf: objective.requiredCount);
    _invalidateFilteredEntryProgress(entry);
  }

  Progress getEntryObjectiveProgress(PikaEntry entry, ObjectiveDto objective) {
    return _entryObjectiveProgress[_getEntryObjectiveProgressKey(entry.id, objective.id)] ?? Progress(outOf: objective.requiredCount);
  }

  Progress getFilteredEntryProgress(PikaEntry entry) {
    if (_filteredEntryProgress.containsKey(entry)) return _filteredEntryProgress[entry]!;

    Progress progress = Progress();

    List<ProjectDto> projectList = projectFilter == null ? domain.projects : [projectFilter!];
    Iterable<ObjectiveDto> objectivesList = projectList.expand((proj) => proj.objectives);

    Iterable<ObjectiveDto> filteredObjectives = objectivesList.where((obj) => obj.entryIds.contains(entry.id));

    for (var objective in filteredObjectives) {
      progress += getEntryObjectiveProgress(entry, objective);
    }

    for (var child in entry.children) {
      progress += getFilteredEntryProgress(child);
    }

    return _filteredEntryProgress[entry] = progress;
  }

  Progress getProjectProgress(ProjectDto project) {
    Progress progress = Progress();
    for (ObjectiveDto objective in project.objectives) {
      for (String entryId in objective.entryIds) {
        String key = _getEntryObjectiveProgressKey(entryId, objective.id);
        progress += _entryObjectiveProgress[key] ?? Progress(outOf: objective.requiredCount);
      }
    }

    return progress;
  }

  String _getEntryObjectiveProgressKey(String entryId, String objectiveId) {
    return '$entryId-$objectiveId';
  }

  void _invalidateFilteredEntryProgress([PikaEntry? entry]) {
    if (entry == null) _filteredEntryProgress.clear();
    while (entry != null) {
      _filteredEntryProgress.remove(entry);
      entry = entry.parent;
    }
  }
}

class Progress {
  Progress({
    this.progress = 0,
    this.outOf = 0,
  });

  int progress;

  final int outOf;

  double get percentage => 1.0 * progress / outOf;

  bool isValid() => outOf >= 0 && progress >= 0 && progress < outOf;

  Progress operator +(Progress other) {
    return Progress(progress: progress + other.progress, outOf: outOf + other.outOf);
  }
}
