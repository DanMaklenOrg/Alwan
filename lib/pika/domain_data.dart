import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/api/dto/response/get_domain_profile_response_dto.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/services.dart';

class DomainData {
  DomainData._({
    required this.id,
    required this.name,
    required this.rootEntry,
    required this.projects,
  });

  static Future<DomainData> fetchDomainData(DomainDto domain) async {
    GetDomainProfileResponseDto profile = await Services.pikaClient.getDomainProfile(domain.id);

    return DomainData._(
      id: domain.id,
      name: domain.name,
      rootEntry: PikaEntry.fromEntryDto(profile.rootEntry),
      projects: profile.projects
    );
  }

  final String id;

  final String name;

  final PikaEntry rootEntry;

  final List<ProjectDto> projects;

  List<ObjectiveDto> getEntryObjectives(PikaEntry entry) {
    return projects.expand<ObjectiveDto>((proj) => proj.objectives).where((obj) => obj.entryIds.contains(entry.id)).toList();
  }
}
