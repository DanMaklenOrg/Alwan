import 'package:alwan/api/api_client.dart';
import 'package:alwan/pika/models/domain.dart';
import 'package:alwan/pika/models/domain_progress.dart';
import 'package:flutter/material.dart';

import '../models/achievement.dart';

class AchievementView extends StatefulWidget {
  const AchievementView({Key? key, required this.domain, required this.progress}) : super(key: key);

  final Domain domain;
  final DomainProgress progress;

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.domain.achievements.length,
      itemBuilder: (context, index) => _buildItem(widget.domain.achievements[index]),
    );
  }

  Widget _buildItem(Achievement achievement) {
    return CheckboxListTile(
      title: Text(achievement.name),
      value: widget.progress.isAchievementUnlocked(achievement),
      onChanged: (val) => setAchievementLockState(achievement, val!),
    );
  }

  void setAchievementLockState(Achievement achievement, bool state) {
    if (state) {
      ApiClient.of(context).putUnlockAchievement(achievement.id);
      widget.progress.unlockAchievement(achievement);
      setState(() {});
    }
  }
}
