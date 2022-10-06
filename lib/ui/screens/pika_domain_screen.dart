import 'dart:async';

import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/pika/domain_data.dart';
import 'package:alwan/pika/widgets/domain_progress_view.dart';
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
  late Future<DomainData> domainData;

  @override
  void initState() {
    super.initState();
    domainData = DomainData.fetchDomainData(widget.domain);
  }

  @override
  void didUpdateWidget(PikaDomainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.domain.id != widget.domain.id) setState(() => domainData = DomainData.fetchDomainData(widget.domain));
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: widget.domain.name,
      body: AsyncDataBuilder<DomainData>(
        dataFuture: domainData,
        builder: (BuildContext context, DomainData data) => DomainProgressView(data),
      ),
    );
  }
}
