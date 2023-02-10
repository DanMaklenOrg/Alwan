import 'package:alwan/ui/common/primary_scaffold.dart';
import 'package:flutter/material.dart';

class NavigationScaffold extends StatelessWidget {
  const NavigationScaffold({
    Key? key,
    required this.title,
    required this.body,
    required this.entries,
    this.showSignInAction = true,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool showSignInAction;

  final List<NavigationEntry> entries;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      title: title,
      showSignInAction: showSignInAction,
      body: Row(
        children: [
          Drawer(child: Column(children: entries)),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class NavigationEntry extends StatelessWidget {
  const NavigationEntry({
    super.key,
    required this.title,
    required this.route,
    this.selected = false,
    this.arguments,
  });

  final String title;
  final String route;
  final bool selected;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      selected: selected,
      selectedTileColor: Colors.black12,
      onTap: () => Navigator.of(context).pushReplacementNamed(route, arguments: arguments),
      title: Text(title),
    );
  }
}
