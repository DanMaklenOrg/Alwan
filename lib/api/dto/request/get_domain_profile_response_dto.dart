import 'package:alwan/api/dto/common/entry_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';

class GetDomainProfileResponseDto {
  GetDomainProfileResponseDto.fromJson(Map<String, dynamic> json)
      : rootEntry = EntryDto.fromJson(json['root_entry']),
        projects = (json['projects'] as Iterable).map((e) => ProjectDto.fromJson(e)).toList();

  EntryDto rootEntry;

  List<ProjectDto> projects;
}
