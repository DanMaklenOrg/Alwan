class ProgressDto {
  ProgressDto({required this.objectiveId, required this.targetId, required this.progress});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'objective_id': objectiveId,
        'target_id': targetId,
        'progress': progress,
      };

  ProgressDto.fromJson(Map<String, dynamic> json)
      : objectiveId = json['objective_id'],
        targetId = json['target_id'],
        progress = json['progress'];

  String objectiveId;
  String targetId;
  int progress;
}
