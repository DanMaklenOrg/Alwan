class EntryDto {
  EntryDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        children = (json['children'] as Iterable).map((e) => EntryDto.fromJson(e)).toList();

  String id;

  String title;

  List<EntryDto> children;
}
