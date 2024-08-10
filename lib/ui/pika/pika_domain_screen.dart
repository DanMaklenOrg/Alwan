import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/dto_converter.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:alwan/ui/pika/pika_domain_view.dart';
import 'package:alwan/ui/pika/pika_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class PikaDomainScreen extends StatefulWidget {
  const PikaDomainScreen({super.key, required this.domainId});

  final String domainId;

  @override
  State<PikaDomainScreen> createState() => _PikaDomainScreenState();
}

class _PikaDomainScreenState extends State<PikaDomainScreen> {
  @override
  Widget build(BuildContext context) {
    return AsyncDataBuilder<_PikaData>(
      fetcher: _fetchData,
      builder: (context, data) => MultiProvider(
        providers: [
          Provider(create: (_) => _buildContainer(data)),
          ChangeNotifierProvider(create: (_) => _buildUserStats(data)),
          ChangeNotifierProvider(create: (_) => PikaFilterState()),
        ],
        child: BaseScreenLayout(
          title: data.rootDomain.name,
          body: const PikaDomainView(),
        ),
      ),
    );
  }

  Future<_PikaData> _fetchData() async {
    var client = serviceProvider.get<ApiClient>();
    return _PikaData(
      baseDomain: await client.getDomain('_'),
      rootDomain: await client.getDomain(widget.domainId),
      userStats: await client.getUserStat(widget.domainId),
    );
  }

  PikaContainer _buildContainer(_PikaData data) {
    var builder = PikaContainerBuilder();
    builder.loadDomain(data.baseDomain, listDomain: false);
    builder.loadDomain(data.rootDomain);
    return builder.build();
  }

  UserStats _buildUserStats(_PikaData data) {
    var converter = DtoConverter();
    var entityStatsList = data.userStats.entityStats.map(converter.fromUserEntityStatDto).toList();
    return UserStats(data.rootDomain.id, entityStatsList, []);
  }
}

class _PikaData {
  _PikaData({required this.baseDomain, required this.rootDomain, required this.userStats});

  final DomainDto baseDomain;
  final DomainDto rootDomain;
  final UserStatsDto userStats;
}
