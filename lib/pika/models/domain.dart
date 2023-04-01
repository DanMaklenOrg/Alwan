import 'package:alwan/pika/models/achievement.dart';

class Domain {
  const Domain({required this.id, required this.name, required this.achievements});

  final String id;
  final String name;
  final List<Achievement> achievements;
}
