import 'package:alwan/api/dto.dart';
import 'package:flutter/material.dart';

final class EntityView extends StatelessWidget {
  const EntityView({super.key, required this.entity});

  final EntityDto entity;

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

  Widget _buildStat(BuildContext context, StatDto stat) {
    return switch (stat.type) {
      StatTypeEnumDto.boolean => _BooleanStatTile(stat),
      StatTypeEnumDto.integerRange => _IntegerRangeStatTile(stat),
    };
  }
}

class _BooleanStatTile extends StatelessWidget {
  _BooleanStatTile(this.stat) : assert(stat.type == StatTypeEnumDto.boolean);

  final StatDto stat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stat.name),
      trailing: Checkbox(value: true, onChanged: (bool? value) {}),
    );
  }
}

class _IntegerRangeStatTile extends StatelessWidget {
  _IntegerRangeStatTile(this.stat) : assert(stat.type == StatTypeEnumDto.integerRange);

  final StatDto stat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stat.name),
      subtitle: Slider.adaptive(
        value: stat.min as double,
        onChanged: (_) {},
        min: stat.min as double,
        max: stat.max as double,
      ),
    );
  }
}
