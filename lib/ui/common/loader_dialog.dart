import 'package:flutter/material.dart';

class LoaderDialog<T> extends StatelessWidget {
  const LoaderDialog._({Key? key, required this.dataFuture}) : super(key: key);

  static Future<T> show<T>(BuildContext context, Future<T> dataFuture) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoaderDialog._(dataFuture: dataFuture),
    );
  }

  final Future<T> dataFuture;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FutureBuilder<T>(
        future: dataFuture,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) Navigator.of(context).pop(snapshot.data);
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
