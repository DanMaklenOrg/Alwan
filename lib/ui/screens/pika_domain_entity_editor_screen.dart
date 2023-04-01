import 'package:alwan/api/api_client.dart';
import 'package:alwan/api/dto/response/entity_dto.dart';
import 'package:alwan/pika/models/domain.dart';
import 'package:alwan/pika/models/entity.dart';
import 'package:alwan/pika/widgets/new_entity_dialog.dart';
import 'package:alwan/pika/widgets/pika_domain_editor_scaffold.dart';
import 'package:alwan/ui/common/forest_list_view.dart';
import 'package:flutter/material.dart';

class PikaDomainEntityEditorScreen extends StatefulWidget {
  const PikaDomainEntityEditorScreen({Key? key, required this.domain}) : super(key: key);

  final Domain domain;

  @override
  State<PikaDomainEntityEditorScreen> createState() => _PikaDomainEntityEditorScreenState();
}

class _PikaDomainEntityEditorScreenState extends State<PikaDomainEntityEditorScreen> {
  Map<String, Entity> entities = {};

  @override
  void initState() {
    super.initState();
    _loadEntities();
  }

  @override
  void didUpdateWidget(covariant PikaDomainEntityEditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.domain.id != oldWidget.domain.id) _loadEntities();
  }

  @override
  Widget build(BuildContext context) {
    return PikaDomainEditorScaffold(
      domain: widget.domain,
      selected: 0,
      body: ForestListView<Entity>(
        roots: entities.values.where((e) => e.parentId == null).toList(),
        parent: (n) => n.parentId == null ? null : entities[n.parentId],
        children: (n) => n.children.map((e) => entities[e]!).toList(),
        title: (n) => n.name,
        appendAction: _addEntity,
      ),
    );
  }

  Future<void> _loadEntities() async {
    List<EntityDto> entityList = await ApiClient.of(context).getEntities(widget.domain.id);
    setState(() => entities = {for (EntityDto entity in entityList) entity.id: Entity.fromDto(entity)});
  }

  Future<void> _addEntity(Entity? parent) async
  {
    String name = await NewEntityDialog.show(context);
    var dto = await ApiClient.of(context).addEntity(widget.domain.id, name, parent?.id);
    var newEntity = Entity.fromDto(dto);
    setState(() {
      entities[newEntity.id] = newEntity;
      if(parent != null) parent.children.add(newEntity.id);
    });
  }
}
