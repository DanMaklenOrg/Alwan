import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_context.dart';
import 'package:flutter/cupertino.dart';

class PikaFilterState extends ChangeNotifier {
  PikaFilterState();

  bool _hideCompletedEntities = true;

  bool get hideCompletedEntities => _hideCompletedEntities;

  set hideCompletedEntities(bool val) {
    _hideCompletedEntities = val;
    notifyListeners();
  }

  String? _domainId;

  String? get domainId => _domainId;

  set domainId(String? val) {
    _domainId = val;
    notifyListeners();
  }

  bool matchEntity(PikaContext context, Entity entity) {
    if (_domainId != null && entity.id.domainId != _domainId) return false;
    if (_hideCompletedEntities && entity.isCompleted(context)) return false;
    return true;
  }

  bool matchProject(PikaContext context, Project project) {
    if (_domainId != null && project.id.domainId != _domainId) return false;
    if (_hideCompletedEntities && project.isCompleted(context)) return false;
    return true;
  }

  bool matchDomain(PikaContext context, Domain domain) {
    if (_hideCompletedEntities && domain.isCompleted(context)) return false;
    return true;
  }
}
