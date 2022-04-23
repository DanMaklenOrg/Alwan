class ObjectiveDto {
  ObjectiveDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        requiredCount = json['required_count'],
        entryIds = (json['entries_id'] as Iterable).map((e) => e as String).toList();

  String id;

  String title;

  int requiredCount;

  List<String> entryIds;
}
