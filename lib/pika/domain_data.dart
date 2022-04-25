import 'dart:collection';
import 'dart:convert';

import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/common/entry_dto.dart';
import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DomainData {
  const DomainData._({
    required this.id,
    required this.name,
    required this.rootEntry,
    required this.projects,
    required Map<String, int> trackedProgress,
  }) : _trackedProgress = trackedProgress;

  static Future<DomainData> fetchDomainData(DomainDto domain) async {
    var profile = await Services.pikaClient.getDomainProfile(domain.id);

    Map<String, int> trackedProgress = await _loadTrackedProgress(domain.id);

    return DomainData._(
      id: domain.id,
      name: domain.name,
      rootEntry: profile.rootEntry,
      projects: profile.projects,
      trackedProgress: trackedProgress,
    );
  }

  final String id;

  final String name;

  final EntryDto rootEntry;

  final List<ProjectDto> projects;

  final Map<String, int> _trackedProgress;

  void setProgress(String entryId, String objectiveId, int value) {
    _trackedProgress['$entryId-$objectiveId'] = value;
  }

  int getProgress(String entryId, String objectiveId) {
    return _trackedProgress['$entryId-$objectiveId'] ?? 0;
  }

  double? getProgressRatio(EntryDto rootEntry, [List<ProjectDto>? projectList]) {
    projectList ??= projects;
    int got = 0;
    int outOf = 0;
    Queue<EntryDto> queue = Queue<EntryDto>();
    queue.add(rootEntry);
    while (queue.isNotEmpty) {
      EntryDto entry = queue.removeFirst();
      queue.addAll(entry.children);
      for (var objective in getEntryObjectives(entry, projectList)) {
        if (objective.entryIds.contains(entry.id)) {
          got += getProgress(entry.id, objective.id);
          outOf += objective.requiredCount;
        }
      }
    }
    if (outOf == 0) return null;
    return 1.0 * got / outOf;
  }

  double? getProjectProgressRatio(ProjectDto project) {
    return getProgressRatio(rootEntry, [project]);
  }

  List<ObjectiveDto> getEntryObjectives(EntryDto entry, [List<ProjectDto>? projectList]) {
    projectList ??= projects;
    return projectList.expand<ObjectiveDto>((proj) => proj.objectives).where((obj) => obj.entryIds.contains(entry.id)).toList();
  }

  Future<void> saveTrackedProgress() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_storageKey(id), json.encode(_trackedProgress));
  }

  static Future<Map<String, int>> _loadTrackedProgress(String domainId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String storageKey = _storageKey(domainId);
    if (!storage.containsKey(storageKey)) return {};
    final Map<String, int> raw = Map.castFrom(json.decode(storage.getString(storageKey)!));
    return raw;
  }

  static String _storageKey(String domainId) {
    return 'DomainData-$domainId';
  }
}
