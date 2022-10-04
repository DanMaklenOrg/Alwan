import 'package:alwan/api/dto/common/entry_dto.dart';

class PikaEntry {
  PikaEntry.fromEntryDto(EntryDto dto)
      : id = dto.id,
        title = dto.title,
        children = dto.children.map((child) => PikaEntry.fromEntryDto(child)).toList() {
    for (var element in children) {
      element.parent = this;
    }
  }

  final String id;
  final String title;
  late final PikaEntry? parent;
  final List<PikaEntry> children;
}
