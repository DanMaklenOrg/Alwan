import 'package:flutter/material.dart';

class ForestListView<T> extends StatefulWidget {
  const ForestListView({
    super.key,
    required this.roots,
    required this.parent,
    required this.children,
    required this.title,
    this.appendAction,
  });

  final List<T> roots;
  final T? Function(T) parent;
  final List<T> Function(T) children;
  final String Function(T) title;

  final void Function(T?)? appendAction;

  @override
  State<ForestListView<T>> createState() => _ForestListViewState<T>();
}

class _ForestListViewState<T> extends State<ForestListView<T>> {
  T? currentNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<T> children = currentNode == null ? widget.roots : widget.children(currentNode!);
    var listLength = children.length + 1;
    if (widget.appendAction != null) listLength++;
    return ListView.builder(
      itemCount: listLength,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) return _buildHeaderListItem();
        if (index == children.length + 1) return _buildAppendListItem();
        return _buildListItem(children[index - 1]);
      },
    );
  }

  Widget _buildHeaderListItem() {
    return ListTile(
      title: Text(currentNode == null ? '/' : widget.title(currentNode!), textAlign: TextAlign.center),
      tileColor: Colors.teal,
      onTap: currentNode == null ? null : () => setState(() => currentNode = widget.parent(currentNode!)),
    );
  }

  Widget _buildListItem(T node) {
    return ListTile(
      title: Text(widget.title(node)),
      onTap: () => setState(() => currentNode = node),
    );
  }

  Widget _buildAppendListItem() {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text("Append"),
      tileColor: Colors.blueGrey,
      onTap: () => widget.appendAction!(currentNode),
    );
  }
}
