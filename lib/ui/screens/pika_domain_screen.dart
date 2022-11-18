import 'dart:async';

import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/response/get_domain_profile_response_dto.dart';
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
  late Future<GetDomainProfileResponseDto> domainProfile;

  @override
  void initState() {
    super.initState();
    domainProfile = ApiClient.of(context).getDomainProfile(widget.domain.id);
  }

  @override
  void didUpdateWidget(PikaDomainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.domain.id != widget.domain.id) setState(() => domainProfile = ApiClient.of(context).getDomainProfile(widget.domain.id));
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: widget.domain.name,
      body: AsyncDataBuilder<GetDomainProfileResponseDto>(
        dataFuture: domainProfile,
        builder: (BuildContext context, GetDomainProfileResponseDto profileDto) {
          return DomainProgressView(widget.domain, profileDto);
        },
      ),
    );
  }
}
