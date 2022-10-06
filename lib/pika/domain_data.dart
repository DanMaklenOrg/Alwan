import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/api/dto/response/get_domain_profile_response_dto.dart';
import 'package:alwan/pika/pika_entry.dart';

class DomainData {
  DomainData._({
    required this.id,
    required this.name,
    required this.rootEntry,
    required this.projects,
  });

  DomainData.fromDomainProfile(DomainDto domain, GetDomainProfileResponseDto profile)
      : this._(
    id: domain.id,
    name: domain.name,
    rootEntry: PikaEntry.fromEntryDto(profile.rootEntry),
    projects: profile.projects,
  );

  final String id;

  final String name;

  final PikaEntry rootEntry;

  final List<ProjectDto> projects;

  List<ObjectiveDto> getEntryObjectives(PikaEntry entry) {
    return _allObjectives().where((obj) => obj.entryIds.contains(entry.id)).toList();
  }

  ObjectiveDto getObjective(String id) {
    return _allObjectives().firstWhere((obj) => obj.id == id);
  }

  List<ObjectiveDto> _allObjectives() {
    return projects.expand<ObjectiveDto>((proj) => proj.objectives).toList();
  }
}
