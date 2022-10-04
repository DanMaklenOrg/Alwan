import 'dart:async';

import 'package:alwan/api/dto/common/domain_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/pika/domain_data.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/ui/common/async_data_builder.dart';
import 'package:alwan/ui/common/primary_scaffold.dart';
import 'package:alwan/ui/dialog/objectives_dialog.dart';
import 'package:flutter/material.dart';

class PikaDomainScreen extends StatefulWidget {
  const PikaDomainScreen({Key? key, required this.domain}) : super(key: key);

  final DomainDto domain;

  @override
  State<PikaDomainScreen> createState() => _PikaDomainScreenState();
}

class _PikaDomainScreenState extends State<PikaDomainScreen> {
  late Future<DomainData> domainData;
  List<PikaEntry> entryPath = [];
  ProjectDto? selectedProject;

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
        builder: (BuildContext context, DomainData data) {
          return Row(
            children: [
              _projectListBuilder(context, data),
              _entryListBuilder(context, data),
            ],
          );
        },
      ),
    );
  }

  Widget _projectListBuilder(BuildContext context, DomainData data) {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: data.projects.length,
        itemBuilder: (context, i) => _buildProjectEntry(context, data, data.projects[i]),
      ),
    );
  }

  Widget _buildProjectEntry(BuildContext context, DomainData data, ProjectDto project) {
    return InkWell(
      child: Container(
        height: 50,
        color: selectedProject == project ? Colors.blue.withOpacity(0.2) : null,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(flex: 20, child: Text(project.title, textAlign: TextAlign.center)),
            Expanded(flex: 2, child: _buildProgress(context, data, data.getProjectProgressRatio(project))),
          ],
        ),
      ),
      onTap: () {
        setState(() => selectedProject = selectedProject == project ? null : project);
      },
    );
  }

  Widget _entryListBuilder(BuildContext context, DomainData data) {
    PikaEntry root = entryPath.isEmpty ? data.rootEntry : entryPath.last;

    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: root.children.length + 1,
        itemBuilder: (context, i) => i == 0 ? _headerEntryBuilder(context, data, root) : _entryBuilder(context, data, root.children[i - 1]),
      ),
    );
  }

  Widget _headerEntryBuilder(BuildContext context, DomainData data, PikaEntry entry) {
    return InkWell(
      child: Container(
        height: 50,
        color: Colors.amber.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(flex: 20, child: Text(entry.title, textAlign: TextAlign.center)),
            Expanded(flex: 2, child: _buildProgress(context, data, data.getProgressRatio(entry, selectedProject))),
          ],
        ),
      ),
      onTap: () {
        if (entryPath.isNotEmpty) setState(() => entryPath.removeLast());
      },
      onDoubleTap: () async {
        var objectives = data.getEntryObjectives(entry, selectedProject);
        if (objectives.isNotEmpty) {
          await ObjectivesDialog.show(context, entry, objectives, data);
          await data.saveTrackedProgress();
          setState(() {});
        }
      },
    );
  }

  Widget _entryBuilder(BuildContext context, DomainData data, PikaEntry entry) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: _buildExpandIcon(context, entry)),
            Expanded(flex: 18, child: Text(entry.title, textAlign: TextAlign.left)),
            Expanded(flex: 2, child: _buildProgress(context, data, data.getProgressRatio(entry, selectedProject))),
          ],
        ),
      ),
      onTap: () {
        if (entry.children.isNotEmpty) setState(() => entryPath.add(entry));
      },
      onDoubleTap: () async {
        var objectives = data.getEntryObjectives(entry, selectedProject);
        if (objectives.isNotEmpty) {
          await ObjectivesDialog.show(context, entry, objectives, data);
          await data.saveTrackedProgress();
          setState(() {});
        }
      },
    );
  }

  Widget _buildExpandIcon(BuildContext context, PikaEntry entry) {
    if (entry.children.isEmpty) return Container();
    return const Icon(Icons.keyboard_arrow_right);
  }

  Widget _buildProgress(BuildContext context, DomainData data, double? progress) {
    if (progress == null) return Container();
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(children: [
        Center(child: CircularProgressIndicator(value: progress, color: Colors.green, backgroundColor: Colors.black26)),
        Center(child: Text('${(progress * 100).floor()}%', style: Theme.of(context).textTheme.bodySmall)),
      ]),
    );
  }
}
