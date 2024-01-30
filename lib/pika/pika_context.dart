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
  late Map<ResourceId, Stat> _stats;

  List<Domain> getSubDomains() {
    var filteredDomains = [rootDomain, ...rootDomain.subDomains];
    filteredDomains.sort((a, b) => a.id.compareTo(b.id));
    return filteredDomains;
  }

  List<Entity> getEntities({bool respectFilterState = true}) {
    var filteredEntities = _entities;
    if (respectFilterState) filteredEntities = filteredEntities.where((e) => filterState.match(this, e)).toList();
    filteredEntities.sort((a, b) => a.name.compareTo(b.name));
    return filteredEntities;
  }

  Stat getStat(ResourceId sid) => _stats[sid]!;
}
