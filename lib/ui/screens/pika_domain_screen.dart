import 'dart:async';

import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/common/entry_dto.dart';
import 'package:alwan/pika/domain_data.dart';
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
  List<EntryDto> entryPath = [];

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
        builder: _entryListBuilder,
      ),
    );
  }

  Widget _entryListBuilder(BuildContext context, DomainData data) {
    EntryDto root = entryPath.isEmpty ? data.rootEntry : entryPath.last;

    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: root.children.length + 1,
        itemBuilder: (context, i) => i == 0 ? _headerEntryBuilder(context, data, root) : _entryBuilder(context, data, root.children[i - 1]),
      ),
    );
  }

  Widget _headerEntryBuilder(BuildContext context, DomainData data, EntryDto entry) {
    return InkWell(
      child: Container(
        height: 50,
        color: Colors.amber.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(flex: 20, child: Text(entry.title, textAlign: TextAlign.center)),
            Expanded(flex: 2,child: _buildProgress(context, data, entry)),
          ],
        ),
      ),
      onTap: () {
        if (entryPath.isNotEmpty) setState(() => entryPath.removeLast());
      },
    );
  }

  Widget _entryBuilder(BuildContext context, DomainData data, EntryDto entry) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: _buildExpandIcon(context, entry)),
            Expanded(flex: 18, child: Text(entry.title, textAlign: TextAlign.left)),
            Expanded(flex: 2, child: _buildProgress(context, data, entry)),
          ],
        ),
      ),
      onTap: () {
        if (entry.children.isNotEmpty) setState(() => entryPath.add(entry));
      },
      onDoubleTap: () {
        print(data.getEntryObjectives(entry).length);
      },
    );
  }

  Widget _buildExpandIcon(BuildContext context, EntryDto entry) {
    if (entry.children.isEmpty) return Container();
    return const Icon(Icons.keyboard_arrow_right);
  }

  Widget _buildProgress(BuildContext context, DomainData data, EntryDto entry) {
    double? progress = data.getProgressRatio(entry);
    if (progress == null) return Container();
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(children: [
        Center(child: CircularProgressIndicator(value: progress, color: Colors.green, backgroundColor: Colors.black26)),
        Center(child: Text('${(progress * 100).toStringAsFixed(0)}%', style: Theme.of(context).textTheme.bodySmall)),
      ]),
    );
  }
}
