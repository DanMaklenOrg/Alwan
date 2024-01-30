import 'package:flutter/material.dart';

class LoadingIconButton extends StatefulWidget {
  const LoadingIconButton({super.key, required this.iconData, required this.onPressed});

  final IconData iconData;
  final Future Function() onPressed;

  @override
  State<LoadingIconButton> createState() => _LoadingIconButtonState();
}

class _LoadingIconButtonState extends State<LoadingIconButton> {
  Future? _future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done && snapshot.connectionState != ConnectionState.none) return const CircularProgressIndicator();
          return IconButton(onPressed: () {
            _future = widget.onPressed();
            setState(() {});
          }, icon: Icon(widget.iconData));
        });
  }
}
