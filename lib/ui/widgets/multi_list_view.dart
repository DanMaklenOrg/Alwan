import 'package:alwan/extensions/flutter_extensions.dart';
import 'package:flutter/material.dart';

typedef ItemBuilderCallback = Widget Function(BuildContext context, int primaryIndex, int secondaryIndex);

class MultiListView extends StatelessWidget {
  const MultiListView({
    Key? key,
    required this.size,
    required this.listSizes,
    this.listKeys,
    required this.itemBuilder,
    this.primaryScrollDirection = Axis.horizontal,
    this.reversePrimaryList = false,
    required this.secondaryListWidth,
  })  : assert(listSizes.length == size),
        assert(listKeys == null || listKeys.length == size),
        super(key: key);

  final int size;
  final List<int> listSizes;
  final List<Key?>? listKeys;
  final ItemBuilderCallback itemBuilder;
  final Axis primaryScrollDirection;
  final bool reversePrimaryList;
  final double secondaryListWidth;

  Axis get secondaryScrollDirection => primaryScrollDirection.flip;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: size,
      itemBuilder: (context, listIndex) => _SecondaryList(
        key: listKeys?[listIndex],
        primaryIndex: listIndex,
        size: listSizes[listIndex],
        itemBuilder: itemBuilder,
        scrollDirection: secondaryScrollDirection,
        width: secondaryListWidth,
      ),
      scrollDirection: primaryScrollDirection,
      reverse: reversePrimaryList,
      addAutomaticKeepAlives: true,
    );
  }
}

class _SecondaryList extends StatefulWidget {
  const _SecondaryList({
    Key? key,
    required this.size,
    required this.primaryIndex,
    required this.itemBuilder,
    required this.scrollDirection,
    required this.width,
  }) : super(key: key);

  final int size;
  final int primaryIndex;
  final ItemBuilderCallback itemBuilder;
  final Axis scrollDirection;
  final double width;

  @override
  State<_SecondaryList> createState() => _SecondaryListState();
}

class _SecondaryListState extends State<_SecondaryList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: widget.width,
      child: ListView.builder(
        controller: _controller,
        itemCount: widget.size,
        itemBuilder: (context, secondaryIndex) => widget.itemBuilder(context, widget.primaryIndex, secondaryIndex),
        scrollDirection: widget.scrollDirection,
      ),
    );
  }
}
