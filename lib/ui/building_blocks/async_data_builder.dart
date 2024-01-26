import 'package:flutter/material.dart';

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);
typedef DataFetcher<T> = Future<T> Function();

class AsyncDataBuilder<T> extends StatefulWidget {
  const AsyncDataBuilder({super.key, required this.fetcher, required this.builder});

  final DataBuilder<T> builder;
  final DataFetcher<T> fetcher;

  @override
  State<AsyncDataBuilder<T>> createState() => _AsyncDataBuilderState<T>();
}

class _AsyncDataBuilderState<T> extends State<AsyncDataBuilder<T>> {
  late final Future<T> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.fetcher();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
        return widget.builder(context, snapshot.data as T);
      },
    );
  }
}
//
// typedef DataLoader = Future Function()
//
// class AsyncStateBuilderChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget
// {
//   const AsyncStateBuilderChangeNotifierProvider({super.key, required this.builder, required this.create});
//
//   final WidgetBuilder builder;
//   final Create<T> create;
//   final Future Function(T) loadInitStat;
//
//   @override
//   State<AsyncStateBuilderChangeNotifierProvider<T>> createState() => _AsyncStateBuilderChangeNotifierProviderState<T>();
// }
//
// class _AsyncStateBuilderChangeNotifierProviderState<T extends ChangeNotifier> extends State<AsyncStateBuilderChangeNotifierProvider<T>> {
//   late final Future<T> _dataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _dataFuture = widget.loadInitStat(T);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: widget.create,
//       child: FutureBuilder(
//         future: _dataFuture,
//         builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
//           return widget.builder(context);
//         },
//       ),
//     );
//   }
// }
