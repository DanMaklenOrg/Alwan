import 'package:alwan/services.dart';
import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.showSignInAction = true,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool showSignInAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (showSignInAction && !Services.authContextProvider.isSignedIn)
            IconButton(
              icon: const Icon(Icons.login_sharp),
              onPressed: () => Navigator.of(context).pushNamed('/signin'),
            ),
        ],
      ),
      body: Center(child: body),
    );
  }
}
