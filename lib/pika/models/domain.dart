import 'package:alwan/api/dto/common/domain_dto.dart';

class Domain {
  Domain({required this.id, required this.name});

  Domain.fromDto(DomainDto dto) : this(id: dto.id, name: dto.name);

  final String id;
  final String name;
}
