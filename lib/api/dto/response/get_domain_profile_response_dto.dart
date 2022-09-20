import 'package:alwan/api/dto/common/progress_dto.dart';

import '../common/entry_dto.dart';
import '../common/project_dto.dart';

class GetDomainProfileResponseDto {
  GetDomainProfileResponseDto.fromJson(Map<String, dynamic> json)
      : rootEntry = EntryDto.fromJson(json['root_entry']),
        projects = (json['projects'] as Iterable).map((e) => ProjectDto.fromJson(e)).toList(),
        progress = (json['progress'] as Iterable).map((e) => ProgressDto.fromJson(e)).toList();

  EntryDto rootEntry;

  List<ProjectDto> projects;

  List<ProgressDto> progress;
}
