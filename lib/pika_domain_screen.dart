import 'dart:async';

import 'package:alwan/pika/pika_domain.dart';
import 'package:alwan/pika/widgets/pika_domain_view.dart';
import 'package:flutter/material.dart';

class PikaDomainScreen extends StatefulWidget {
  const PikaDomainScreen({Key? key, required this.domain}) : super(key: key);

  final PikaDomain domain;

  @override
  State<PikaDomainScreen> createState() => _PikaDomainScreenState();
}

class _PikaDomainScreenState extends State<PikaDomainScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadPikaDomain();
  }

  @override
  void didUpdateWidget(PikaDomainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.domain != widget.domain) {
      _loadPikaDomain();
    }
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
      body: widget.domain.isLoaded ? PikaDomainView(widget.domain.root) : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _loadPikaDomain() async {
    if (await widget.domain.load()) {
      setState(() {
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 5), _saveTimerCallback);
      });
    }
  }

  void _saveTimerCallback(Timer timer) {
    widget.domain.save();
  }
}
