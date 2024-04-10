import 'package:alwan/api/dto.dart';
import 'package:alwan/pika/resource_map.dart';

import 'dto_converter.dart';
import 'models.dart';

final class PikaContainer {
  PikaContainer.empty()
      : domains = [],
        stats = {},
        tags = {},
        classes = {},
        entities = {},
        projects = {};

  final List<Domain> domains;
  final ResourceMap<Stat> stats;
  final ResourceMap<Tag> tags;
  final ResourceMap<Class> classes;
  final ResourceMap<Entity> entities;
  final ResourceMap<Project> projects;
}

final class PikaContainerBuilder {
  final PikaContainer container = PikaContainer.empty();

  final List<DomainDto> _domains = [];
  final List<StatDto> _statsDto = [];
  final List<TagDto> _tagsDto = [];
  final List<ClassDto> _classesDto = [];
  final List<EntityDto> _entitiesDto = [];
  final List<ProjectDto> _projectsDto = [];

  void loadDomain(DomainDto domain, {bool listDomain = true}) {
    final domainList = _flattenSubDomains(domain);
    _statsDto.addAll(domainList.expand((d) => d.stats));
    _tagsDto.addAll(domainList.expand((d) => d.tags));
    _classesDto.addAll(domainList.expand((d) => d.classes));
    _entitiesDto.addAll(domainList.expand((d) => d.entities));
    _projectsDto.addAll(domainList.expand((d) => d.projects));
    if (listDomain) _domains.addAll([for (var d in domainList) d]);
  }

  PikaContainer build() {
    DtoConverter converter = DtoConverter(container);
    container.stats.addResourceList(_statsDto.map(converter.fromStatDto));
    container.tags.addResourceList(_tagsDto.map(converter.fromTagDto));
    container.classes.addResourceList(_classesDto.map(converter.fromClassDto));

    container.entities.addResourceList(_entitiesDto.map(converter.fromEntityDto));

    container.projects.addResourceList(_projectsDto.map(converter.fromProjectDto));

    container.domains.addAll(_domains.map(converter.fromDomainDto));
    container.domains.sort((a, b) => a.name.compareTo(b.name));
    return container;
  }

  Iterable<DomainDto> _flattenSubDomains(DomainDto dto) sync* {
    yield dto;
    for (var subDomain in dto.subDomains) {
      yield* _flattenSubDomains(subDomain);
    }
  }
}
