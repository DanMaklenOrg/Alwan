import 'package:alwan/api/dto/common/objective_dto.dart';
import 'package:alwan/api/dto/common/progress_dto.dart';
import 'package:alwan/api/dto/common/project_dto.dart';
import 'package:alwan/pika/domain_data.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/pika/pika_progress_tracker.dart';
import 'package:alwan/services.dart';
import 'package:flutter/material.dart';

import 'objectives_dialog.dart';

class DomainProgressView extends StatefulWidget {
  const DomainProgressView(this.domain, {Key? key}) : super(key: key);

  final DomainData domain;

  @override
  State<DomainProgressView> createState() => _DomainProgressViewState();
}

class _DomainProgressViewState extends State<DomainProgressView> {
  late PikaProgressTracker progressTracker;
  List<PikaEntry> entryPath = [];

  @override
  void initState() {
    super.initState();
    progressTracker = PikaProgressTracker(widget.domain);
  }

  @override
  void didUpdateWidget(DomainProgressView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.domain.id != widget.domain.id) setState(() => progressTracker = PikaProgressTracker(widget.domain));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _projectListBuilder(),
        _entryListBuilder(),
      ],
    );
  }

  Widget _projectListBuilder() {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: widget.domain.projects.length,
        itemBuilder: (context, i) => _buildProjectEntry(widget.domain.projects[i]),
      ),
    );
  }

  Widget _buildProjectEntry(ProjectDto project) {
    return InkWell(
      child: Container(
        height: 50,
        color: progressTracker.projectFilter == project ? Colors.blue.withOpacity(0.2) : null,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(flex: 20, child: Text(project.title, textAlign: TextAlign.center)),
            Expanded(flex: 2, child: _buildProgress(progressTracker.getProjectProgress(project))),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          if (progressTracker.projectFilter == project) {
            progressTracker.clearFilter();
          } else {
            progressTracker.setFilter(project);
          }
        });
      },
    );
  }

  Widget _entryListBuilder() {
    PikaEntry root = entryPath.isEmpty ? widget.domain.rootEntry : entryPath.last;

    return SizedBox(
      width: 400,
      child: ListView.builder(
        itemCount: root.children.length + 1,
        itemBuilder: (context, i) => i == 0 ? _headerEntryBuilder(root) : _entryBuilder(root.children[i - 1]),
      ),
    );
  }

  Widget _headerEntryBuilder(PikaEntry entry) {
    return InkWell(
      child: Container(
        height: 50,
        color: Colors.amber.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(flex: 20, child: Text(entry.title, textAlign: TextAlign.center)),
            Expanded(flex: 2, child: _buildProgress(progressTracker.getFilteredEntryProgress(entry))),
          ],
        ),
      ),
      onTap: () {
        if (entryPath.isNotEmpty) setState(() => entryPath.removeLast());
      },
      onDoubleTap: () async {
        var objectives = widget.domain.getEntryObjectives(entry);
        if (objectives.isNotEmpty) {
          await ObjectivesDialog.show(context, entry, objectives, progressTracker);
          // await widget.domain.saveTrackedProgress();
          setState(() {});
        }
      },
    );
  }

  Widget _entryBuilder(PikaEntry entry) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: _buildExpandIcon(context, entry)),
            Expanded(flex: 18, child: Text(entry.title, textAlign: TextAlign.left)),
            Expanded(flex: 2, child: _buildProgress(progressTracker.getFilteredEntryProgress(entry))),
          ],
        ),
      ),
      onTap: () {
        if (entry.children.isNotEmpty) setState(() => entryPath.add(entry));
      },
      onDoubleTap: () async {
        var objectives = widget.domain.getEntryObjectives(entry);
        if (objectives.isNotEmpty) {
          Map<ObjectiveDto, Progress> newProgress = await ObjectivesDialog.show(context, entry, objectives, progressTracker);
          for(ObjectiveDto objective in newProgress.keys){
            Progress progress = newProgress[objective]!;
            progressTracker.setEntryObjectiveProgress(entry, objective, progress.progress);
            await Services.pikaClient.putProgress(ProgressDto(objectiveId: objective.id, targetId: entry.id, progress: progress.progress));
          }
          setState(() {

          });
        }
      },
    );
  }

  Widget _buildExpandIcon(BuildContext context, PikaEntry entry) {
    if (entry.children.isEmpty) return Container();
    return const Icon(Icons.keyboard_arrow_right);
  }

  Widget _buildProgress(Progress progress) {
    if (!progress.isValid()) return Container();
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(children: [
        Center(child: CircularProgressIndicator(value: progress.percentage, color: Colors.green, backgroundColor: Colors.black26)),
        Center(child: Text('${(progress.percentage * 100).floor()}%', style: Theme.of(context).textTheme.bodySmall)),
      ]),
    );
  }
}
