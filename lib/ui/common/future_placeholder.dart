import 'package:flutter/material.dart';

typedef _DataBuilder<T> = Widget Function(BuildContext context, T data);

class AsyncDataBuilder<T> extends StatelessWidget {
  const AsyncDataBuilder({Key? key, required this.dataFuture, required this.builder}) : super(key: key);

  final Future<T> dataFuture;
  final _DataBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: dataFuture,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const CircularProgressIndicator();
        return builder(context, snapshot.data!);
      },
    );
  }
}
