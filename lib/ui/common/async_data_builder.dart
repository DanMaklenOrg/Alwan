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
        if (snapshot.connectionState != ConnectionState.done) return const CircularProgressIndicator();
        return widget.builder(context, snapshot.data as T);
      },
    );
  }
}
