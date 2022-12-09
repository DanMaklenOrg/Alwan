import 'dart:async';

import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/ui/common/async_data_builder.dart';
import 'package:alwan/ui/common/primary_scaffold.dart';
import 'package:flutter/material.dart';

class PikaHomeScreen extends StatefulWidget {
  const PikaHomeScreen({Key? key}) : super(key: key);

  @override
  State<PikaHomeScreen> createState() => _PikaHomeScreenState();
}

class _PikaHomeScreenState extends State<PikaHomeScreen> {
  late Future<List<DomainDto>> domainsFuture;

  @override
  void initState() {
    super.initState();
    domainsFuture = ApiClient.of(context).getDomainList();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: 'Pika',
      body: AsyncDataBuilder<List<DomainDto>>(
        dataFuture: domainsFuture,
        builder: _domainListBuilder,
      ),
    );
  }

  Widget _domainListBuilder(BuildContext context, List<DomainDto> domainList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250),
      itemCount: domainList.length,
      itemBuilder: (context, i) => _domainCard(context, domainList[i]),
    );
  }

  Widget _domainCard(BuildContext context, DomainDto domain) {
    return Card(
      child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('/pika/domain', arguments: domain),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(domain.name, style: Theme.of(context).textTheme.headlineSmall),
            ],
          )),
    );
  }
}
