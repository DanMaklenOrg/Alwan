class AchievementDto {
  AchievementDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  String id;
  String name;
}
