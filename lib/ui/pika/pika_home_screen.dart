import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/base_screen_layout.dart';
import 'package:alwan/ui/building_blocks/async_data_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class PikaHomeScreen extends StatelessWidget {
  const PikaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
      title: 'Pika',
      body: AsyncDataBuilder<List<DomainSummaryDto>>(
        fetcher: serviceProvider.get<ApiClient>().getAllDomains,
        builder: _buildGrid,
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<DomainSummaryDto> domainList) {
    return GridView.extent(
      maxCrossAxisExtent: 250,
      children: domainList.map((e) => _domainCard(context, e)).toList(),
    );
  }

  Widget _domainCard(BuildContext context, DomainSummaryDto domain) {
    return GestureDetector(
      onTap: () => context.go("/pika/${domain.id}"),
      child: Card(
        child: Align(
          alignment: Alignment.center,
          child: Text(domain.name, style: Theme.of(context).textTheme.headlineSmall),
        ),
      ),
    );
  }
}
