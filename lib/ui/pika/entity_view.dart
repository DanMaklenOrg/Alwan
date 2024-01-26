import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class EntityView extends StatelessWidget {
  const EntityView({super.key, required this.entity});

  final Entity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(entity.name, style: Theme.of(context).textTheme.headlineMedium),
        ),
        Expanded(child: _buildStatList()),
      ],
    );
  }

  Widget _buildStatList() {
    return ListView.separated(
      itemCount: entity.stats.length,
      itemBuilder: (_, index) => _buildStat(_, entity.stats[index]),
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  Widget _buildStat(BuildContext context, Stat stat) {
    var state = context.watch<PikaState>();
    return switch (stat.type) {
      StatType.boolean => _BooleanStatTile(
          stat,
          value: state.getStatValue(entity, stat) == 1,
          onChanged: (bool val) => state.setStatValue(entity, stat, val ? 1 : 0),
        ),
      StatType.integerRange => _IntegerRangeStatTile(
          stat,
          value: state.getStatValue(entity, stat),
          onChanged: (int val) => state.setStatValue(entity, stat, val),
        ),
    };
  }
}

class _BooleanStatTile extends StatelessWidget {
  _BooleanStatTile(this.stat, {required this.value, required this.onChanged}) : assert(stat.type == StatType.boolean);

  final Stat stat;
  final bool value;

  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stat.name),
      trailing: Checkbox(
        value: value,
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}

class _IntegerRangeStatTile extends StatelessWidget {
  _IntegerRangeStatTile(this.stat, {required int? value, required this.onChanged})
      : assert(stat.type == StatType.integerRange),
        value = value ?? stat.min!;

  final Stat stat;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stat.name),
      leadingAndTrailingTextStyle: Theme.of(context).textTheme.labelLarge,
      trailing: Text("$value/${stat.max}"),
      subtitle: Slider(
        value: value.toDouble(),
        onChanged: (val) => onChanged(val.toInt()),
        min: stat.min as double,
        max: stat.max as double,
        divisions: (stat.max! - stat.min! + 1),
        label: value.toString(),

        // onChanged: (_) {},
      ),
    );
  }
}
