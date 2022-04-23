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
    required Map<List<String>, int> trackedProgress,
  }) : _trackedProgress = trackedProgress;

  static Future<DomainData> fetchDomainData(DomainDto domain) async {
    var profile = await Services.pikaClient.getDomainProfile(domain.id);

    Map<List<String>, int> trackedProgress = await _loadTrackedProgress(domain.id);

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

  final Map<List<String>, int> _trackedProgress;

  void setProgress(String entryId, String objectiveId, int value) {
    _trackedProgress[[entryId, objectiveId]] = value;
    _saveTrackedProgress(_trackedProgress, id);
  }

  int getProgress(String entryId, String objectiveId) {
    return _trackedProgress[[entryId, objectiveId]] ?? 0;
  }

  double? getProgressRatio(EntryDto rootEntry) {
    int got = 0;
    int outOf = 0;
    Queue<EntryDto> queue = Queue<EntryDto>();
    queue.add(rootEntry);
    while (queue.isNotEmpty) {
      EntryDto entry = queue.removeFirst();
      queue.addAll(entry.children);
      for (var objective in getEntryObjectives(entry)) {
        if (objective.entryIds.contains(entry.id)) {
          got += getProgress(entry.id, objective.id);
          outOf += objective.requiredCount;
        }
      }
    }
    if (outOf == 0) return null;
    return 1.0 * got / outOf;
  }

  List<ObjectiveDto> getEntryObjectives(EntryDto entry) {
    return projects.expand<ObjectiveDto>((proj) => proj.objectives).where((obj) => obj.entryIds.contains(entry.id)).toList();
  }

  static Future<void> _saveTrackedProgress(Map<List<String>, int> progress, String domainId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_storageKey(domainId), json.encode(progress));
  }

  static Future<Map<List<String>, int>> _loadTrackedProgress(String domainId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String storageKey = _storageKey(domainId);
    if (!storage.containsKey(storageKey)) return {};
    final String json = storage.getString(storageKey)!;
    var x = jsonDecode(json);
    return x;
  }

  static String _storageKey(String domainId) {
    return 'DomainData-$domainId';
  }
}
