import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/user_stats.dart';
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
      itemCount: entity.allStats.length,
      itemBuilder: (context, index) => _buildStat(context, entity.allStats[index]),
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  Widget _buildStat(BuildContext context, Stat stat) {
    var userStats = context.watch<UserStats>();
    var statValue = userStats.getStatValue(entity, stat);
    return switch (stat.type) {
      StatType.boolean => _BooleanStatTile(
          stat,
          value: statValue == "true",
          onChanged: (bool val) => userStats.setStatValue(entity, stat, val.toString()),
        ),
      StatType.integerRange => _IntegerRangeStatTile(
          stat,
          entity,
          value: statValue == null ? null : int.parse(statValue),
          onChanged: (int val) => userStats.setStatValue(entity, stat, val.toString()),
        ),
      StatType.orderedEnum => _OrderedEnumStatTile(
          stat,
          value: statValue,
          onChanged: (String val) => userStats.setStatValue(entity, stat, val.toString()),
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
  _IntegerRangeStatTile(this.stat, this.entity, {required int? value, required this.onChanged})
      : assert(stat.type == StatType.integerRange),
        value = value ?? (stat.min?.getValueForEntity(entity))!;

  final Entity entity;
  final Stat stat;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    var statMin = stat.min!.getValueForEntity(entity);
    var statMax = stat.max!.getValueForEntity(entity);
    return _StatTile(
      statName: stat.name,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: value.toDouble(),
            onChanged: (val) => onChanged(val.toInt()),
            min: statMin as double,
            max: statMax as double,
            divisions: (statMax - statMin + 1),
            label: value.toString(),
          ),
          Text("$value/${statMax}", style: Theme.of(context).textTheme.labelLarge),
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
