import 'dart:async';

import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto/response/domain_dto.dart';
import 'package:alwan/pika/widgets/new_domain_dialog.dart';
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
      itemCount: domainList.length + 1,
      itemBuilder: (context, i) => i == domainList.length ? _newDomainCard(context) : _domainCard(context, domainList[i]),
    );
  }

  Widget _domainCard(BuildContext context, DomainDto domain) {
    return Card(
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/pika/domain', arguments: domain),
            child: Align(
              alignment: Alignment.center,
              child: Text(domain.name, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     icon: const Icon(Icons.edit),
          //     onPressed: () => Navigator.of(context).pushNamed('/pika/edit/entity', arguments: domain),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _newDomainCard(context) {
    return Card(
      child: InkWell(
        onTap: () async {
          String domainName = await NewDomainDialog.show(context);
          await ApiClient.of(context).addDomain(domainName);
          setState(() {
            domainsFuture = ApiClient.of(context).getDomainList();
          });
        },
        child: const Icon(Icons.add, size: 150, color: Colors.green),
      ),
    );
  }
}
