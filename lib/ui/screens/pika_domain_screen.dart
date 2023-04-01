import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto/response/domain_dto.dart';
import 'package:alwan/pika/models/achievement.dart';
import 'package:alwan/pika/models/domain.dart';
import 'package:alwan/pika/models/domain_progress.dart';
import 'package:alwan/pika/widgets/achievement_view.dart';
import 'package:alwan/ui/common/async_data_builder.dart';
import 'package:alwan/ui/common/primary_scaffold.dart';
import 'package:flutter/material.dart';

class PikaDomainScreen extends StatefulWidget {
  const PikaDomainScreen({Key? key, required this.domain}) : super(key: key);

  final DomainDto domain;

  @override
  State<PikaDomainScreen> createState() => _PikaDomainScreenState();
}

class _PikaDomainScreenState extends State<PikaDomainScreen> {
  late Domain domain;
  late DomainProgress progress;
  late Future<bool> dataLoader;

  @override
  void initState() {
    super.initState();
    dataLoader = _loadDomainData();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: widget.domain.name,
      body: AsyncDataBuilder<bool>(
        dataFuture: dataLoader,
        builder: (BuildContext context, bool done) {
          return AchievementView(domain: domain, progress: progress);
        },
      ),
    );
  }

  Future<bool> _loadDomainData() async {
    List<Achievement> achievements = (await ApiClient.of(context).getAchievements(widget.domain.id)).map(Achievement.fromDto).toList();
    domain = Domain(id: widget.domain.id, name: widget.domain.name, achievements: achievements);
    progress = DomainProgress(domain);
    return true;
  }
}
