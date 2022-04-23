import 'package:alwan/api/dto/common/objective_dto.dart';

class ProjectDto {
  ProjectDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        objectives = (json['objectives'] as Iterable).map((e) => ObjectiveDto.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'objectives': objectives,
  };

  String id;

  String title;

  List<ObjectiveDto> objectives;
}
