import 'dart:collection';

import 'package:alwan/api/dto/common/entry_dto.dart';

class PikaEntry {
  PikaEntry._fromEntryDto(EntryDto dto, [EntryDto? parentDto])
      : id = dto.id,
        title = dto.title,
        parentId = parentDto?.id,
        children = dto.children.map((child) => child.id).toList();

  static Map<String, PikaEntry> flattenEntryDto(EntryDto dto, [EntryDto? parentDto]) {
    HashMap<String, PikaEntry> res = HashMap<String, PikaEntry>();

    res[dto.id] = PikaEntry._fromEntryDto(dto);

    for (EntryDto child in dto.children) {
      res.addAll(flattenEntryDto(child, parentDto));
    }

    return res;
  }

  final String id;
  final String title;
  final String? parentId;
  final List<String> children;
}
