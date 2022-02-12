import 'dart:async';

import 'package:alwan/pika/domain/warframe_pika_manager.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/pika/widgets/pika_domain_view.dart';
import 'package:flutter/material.dart';

class WarframeScreen extends StatefulWidget {
  const WarframeScreen({Key? key}) : super(key: key);

  @override
  State<WarframeScreen> createState() => _WarframeScreenState();
}

class _WarframeScreenState extends State<WarframeScreen> {
  late PikaEntry _projectList;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _projectList = WarframePikaManager().domain;
    _timer = Timer.periodic(const Duration(seconds: 5), _saveTimer);
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warframe'),
      ),
      body: PikaDomainView(_projectList),
    );
  }

  void _saveTimer(Timer timer){
    // TODO: Save
  }
}
