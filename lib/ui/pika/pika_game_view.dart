import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/dto_converter.dart';
import 'package:alwan/pika/models.dart';
import 'package:alwan/pika/pika_container.dart';
import 'package:alwan/pika/user_stats.dart';
import 'package:alwan/service_provider.dart';
import 'package:alwan/ui/building_blocks/loading_icon_button.dart';
import 'package:alwan/ui/pika/pika_filter_state.dart';
import 'package:alwan/ui/pika/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pika_resource_list_view.dart';
import 'entity_view.dart';

class PikaGameView extends StatefulWidget {
  const PikaGameView({super.key});

  @override
  State<PikaGameView> createState() => _PikaGameViewState();
}

class _PikaGameViewState extends State<PikaGameView> {
  Achievement? _selectedAchievement;
  Objective? _selectedObjective;
  Entity? _selectedEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(child: _buildMainView()),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._filters(),
        const Spacer(),
        LoadingIconButton(iconData: Icons.save_outlined, onPressed: _saveUserStats),
      ],
    );
  }

  List<Widget> _filters() {
    var filterState = context.watch<PikaFilterState>();
    return [
      SizedBox(
        width: 175,
        child: CheckboxListTile(
          title: const Text("Hide Completed"),
          value: filterState.hideCompletedEntities.value,
          onChanged: (value) => setState(() => filterState.hideCompletedEntities.value = value ?? false),
        ),
      ),
    ];
  }

  Row _buildMainView() {
    return Row(
      children: [
        Expanded(child: _buildAchievementColumn()),
        Expanded(child: _buildEntityList()),
        Expanded(child: _selectedEntity != null ? EntityView(entity: _selectedEntity!) : Container()),
      ],
    );
  }

  Widget _buildAchievementColumn() {
    var container = context.read<PikaContainer>();
    var filterState = context.watch<PikaFilterState>();
    var userStats = context.watch<UserStats>();
    var list = PikaResourceListView<Achievement>(
      resourceList: filterState.filterAchievement(container.achievements, userStats),
      selectedResource: _selectedAchievement,
      onSelection: (achievement) => setState(() {
        _selectedEntity = null;
        _selectedObjective = null;
        _selectedAchievement = achievement;
      }),
    );
    if (_selectedAchievement == null) return list;
    return Column(
      children: [
        Expanded(child: list),
        Expanded(
            child: AchievementView(
          achievement: _selectedAchievement!,
          selectedObjective: _selectedObjective,
          onSelection: (o) => setState(() {
            _selectedEntity = null;
            _selectedObjective = o;
          }),
        )),
      ],
    );
  }

  Widget _buildEntityList() {
    var container = context.read<PikaContainer>();
    var filterState = context.watch<PikaFilterState>();
    var userStats = context.watch<UserStats>();
    var entityList = container.getEntitiesMatchingObjective(_selectedObjective);
    return PikaResourceListView<Entity>(
      resourceList: filterState.filterEntity(entityList, userStats),
      selectedResource: _selectedEntity,
      onSelection: (entity) => setState(() => _selectedEntity = entity),
    );
  }

  Future _saveUserStats() async {
    var userStats = context.read<UserStats>();
    var converter = DtoConverter();
    var entityStats = userStats.getEntityStatList().map(converter.toEntityUserStatDto).toList();
    var dto = UserStatsDto(entityStats: entityStats);
    await serviceProvider.get<ApiClient>().setUserStat(userStats.rootGameId, dto);
  }
}
