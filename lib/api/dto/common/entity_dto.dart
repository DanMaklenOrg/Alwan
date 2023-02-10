class EntityDto {
  EntityDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        parentId = json['parent'],
        children = json['children'].cast<String>();

  String id;
  String name;
  String? parentId;
  List<String> children;
}
