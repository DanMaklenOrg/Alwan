import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/ui/widgets/multi_list_view.dart';
import 'package:flutter/material.dart';

class PikaDomainView extends StatefulWidget {
  const PikaDomainView(this.rootEntry, {Key? key}) : super(key: key);

  final PikaEntry rootEntry;

  @override
  State<PikaDomainView> createState() => _PikaDomainViewState();
}

class _PikaDomainViewState extends State<PikaDomainView> {
  late final List<PikaEntry> _entryPathSegments;
  bool taken = false;

  @override
  void initState() {
    super.initState();
    _entryPathSegments = [widget.rootEntry];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MultiListView(
        size: _entryPathSegments.length,
        listSizes: _entryPathSegments.map((e) => e.children.length).toList(),
        itemBuilder: _buildListItem,
        secondaryListWidth: 300,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int segmentIndex, int childIndex) {
    final PikaEntry entry = _getEntryFromPath(segmentIndex, childIndex);

    return ListTile(
      title: Text(_getEntryFromPath(segmentIndex, childIndex).title),
      trailing: Checkbox(
        value: entry.state,
        onChanged: (value) => setState(() => entry.state = value ?? false),
      ),
      onTap: () => _changeSegment(entry, segmentIndex + 1),
    );
  }

  void _changeSegment(PikaEntry newSegment, int at) {
    setState(() {
      _entryPathSegments.removeRange(at, _entryPathSegments.length);
      if (newSegment.children.isNotEmpty) {
        _entryPathSegments.add(newSegment);
      }
    });
  }

  PikaEntry _getEntryFromPath(int segmentIndex, int childIndex) {
    return _entryPathSegments[segmentIndex].children[childIndex];
  }
}
