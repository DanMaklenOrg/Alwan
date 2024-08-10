import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/resource_map.dart';

import 'dto_converter.dart';
import 'models.dart';

final class PikaContainer {
  PikaContainer.empty()
      : stats = {},
        classes = {},
        entities = {},
        projects = [];

  late final Domain domain;
  final ResourceMap<Stat> stats;
  final ResourceMap<Class> classes;
  final ResourceMap<Entity> entities;
  final List<Project> projects;

  List<Entity> getEntitiesByClassList(List<Class> classList) {
    return entities.toResourceList().where((e) => e.classes.any((element) => classList.contains(element))).toList();
  }
}

final class PikaContainerBuilder {
  final PikaContainer container = PikaContainer.empty();

  late final DomainDto _domain;
  final List<StatDto> _statsDto = [];
  final List<ClassDto> _classesDto = [];
  final List<EntityDto> _entitiesDto = [];
  final List<ProjectDto> _projectsDto = [];

  void loadDomain(DomainDto domain, {bool listDomain = true}) {
    final domainList = [domain];
    _classesDto.addAll(domainList.expand((d) => d.classes));
    _entitiesDto.addAll(domainList.expand((d) => d.entities));
    _projectsDto.addAll(domainList.expand((d) => d.projects));
    _domain = domain;
  }

  PikaContainer build() {
    DtoConverter converter = DtoConverter(container);
    container.stats.addResourceList(_statsDto.map(converter.fromStatDto));
    container.classes.addResourceList(_classesDto.map(converter.fromClassDto));
    container.entities.addResourceList(_entitiesDto.map(converter.fromEntityDto));
    container.projects.addAll(_projectsDto.map(converter.fromProjectDto));
    container.domain = converter.fromDomainDto(_domain);
    return container;
  }
}
