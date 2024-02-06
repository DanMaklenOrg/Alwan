import 'package:alwan/pika/pika_filter_state.dart';
import 'package:flutter/material.dart';

import 'models.dart';
import 'user_stats.dart';

class PikaContext extends ChangeNotifier {
  PikaContext({required this.baseDomain, required this.rootDomain, required this.userStats}) : filterState = PikaFilterState() {
    userStats.addListener(notifyListeners);
    filterState.addListener(notifyListeners);

    _domains = [baseDomain, ...baseDomain.subDomains, rootDomain, ...rootDomain.subDomains];
    _entities = [for (var d in _domains) ...d.entities];
    _projects = [for (var d in _domains) ...d.projects];
    _stats = {
      for (var d in _domains)
        for (var kvp in d.stats.entries) kvp.key: kvp.value
    };
  }

  final Domain baseDomain;
  final Domain rootDomain;
  final UserStats userStats;
  final PikaFilterState filterState;

  late List<Domain> _domains;
  late List<Entity> _entities;
  late List<Project> _projects;
  late Map<ResourceId, Stat> _stats;

  List<Domain> getSubDomains({bool respectFilterState = true}) {
    var filteredDomains = [rootDomain, ...rootDomain.subDomains];
    if (respectFilterState) filteredDomains = filteredDomains.where((e) => filterState.matchDomain(this, e)).toList();
    filteredDomains.sort((a, b) => a.name.compareTo(b.name));
    return filteredDomains;
  }

  List<Entity> getEntities({bool respectFilterState = true}) {
    var filteredEntities = _entities;
    if (respectFilterState) filteredEntities = filteredEntities.where((e) => filterState.matchEntity(this, e)).toList();
    filteredEntities.sort((a, b) => a.name.compareTo(b.name));
    return filteredEntities;
  }

  List<Project> getProjects({bool respectFilterState = true}){
    var filteredProjects = _projects;
    if (respectFilterState) filteredProjects = filteredProjects.where((e) => filterState.matchProject(this, e)).toList();
    filteredProjects.sort((a, b) => a.name.compareTo(b.name));
    return filteredProjects;
  }

  Stat getStat(ResourceId sid) => _stats[sid]!;
}
