import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_context.dart';
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
          child: Text(entity.name, style: Theme.of(context).textTheme.headlineLarge),
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

  Widget _buildStat(BuildContext context, ResourceId statId) {
    var state = context.watch<PikaContext>();
    var stat = state.getStat(statId);
    var statValue = state.userStats.getStatValue(entity, stat);
    return switch (stat.type) {
      StatType.boolean => _BooleanStatTile(
          stat,
          value: statValue == "true",
          onChanged: (bool val) => state.userStats.setStatValue(entity, stat, val.toString()),
        ),
      StatType.integerRange => _IntegerRangeStatTile(
          stat,
          value: statValue == null ? null : int.parse(statValue),
          onChanged: (int val) => state.userStats.setStatValue(entity, stat, val.toString()),
        ),
      StatType.orderedEnum => _OrderedEnumStatTile(
          stat,
          value: statValue,
          onChanged: (String val) => state.userStats.setStatValue(entity, stat, val.toString()),
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
    return _StatTile(
      statName: stat.name,
      child: Checkbox(
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
    return _StatTile(
      statName: stat.name,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: value.toDouble(),
            onChanged: (val) => onChanged(val.toInt()),
            min: stat.min as double,
            max: stat.max as double,
            divisions: (stat.max! - stat.min! + 1),
            label: value.toString(),
          ),
          Text("$value/${stat.max}", style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _OrderedEnumStatTile extends StatelessWidget {
  _OrderedEnumStatTile(this.stat, {required String? value, required this.onChanged})
      : assert(stat.type == StatType.orderedEnum),
        value = value ?? stat.enumValues!.first;

  final Stat stat;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return _StatTile(
      statName: stat.name,
      child: DropdownButton<String>(
        value: value,
        items: stat.enumValues!.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.statName, required this.child});

  final String statName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(statName, style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(child: Align(alignment: Alignment.centerRight, child: child)),
        ],
      ),
    );
  }
}
