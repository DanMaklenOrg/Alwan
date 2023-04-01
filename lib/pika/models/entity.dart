import 'package:alwan/api/dto/response/entity_dto.dart';

class Entity {
  Entity.fromDto(EntityDto dto)
      : id = dto.id,
        name = dto.name,
        parentId = dto.parentId,
        children = dto.children;

  String id;
  String name;
  String? parentId;
  List<String> children;
}
