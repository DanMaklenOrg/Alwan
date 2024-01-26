import 'package:alwan/api/dto.dart';

import 'models.dart';

final class DtoParser {
  static Domain parseDomainDto(DomainDto dto, DomainDto baseDomain) {
    var (entities, stats) = _flatten(dto, baseDomain);
    var statSet = {for (var s in stats) s.id: _parseStatDto(s)};
    var entityList = entities.map((e) => _parseEntityDto(e, statSet)).toList();
    return Domain(id: dto.id, name: dto.name, entities: entityList);
  }

  static Entity _parseEntityDto(EntityDto dto, Map<String, Stat> statSet) {
    return Entity(id: dto.id, name: dto.name, stats: dto.stats.map((s) => statSet[s]!).toList());
  }

  static Stat _parseStatDto(StatDto dto) {
    return Stat(
        id: dto.id,
        name: dto.name,
        type: switch (dto.type) { StatTypeEnumDto.boolean => StatType.boolean, StatTypeEnumDto.integerRange => StatType.integerRange },
        min: dto.min,
        max: dto.max);
  }

  static (List<EntityDto>, List<StatDto>) _flatten(DomainDto dto, DomainDto baseDomain) {
    var domains = [dto, ...dto.subDomains, baseDomain, ...baseDomain.subDomains];
    return (domains.expand((d) => d.entities).toList(), domains.expand((d) => d.stats).toList());
  }
}
