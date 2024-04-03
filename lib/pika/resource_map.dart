import 'package:alwan/pika/models.dart';

typedef ResourceMap<T extends Resource> = Map<ResourceId, T>;

extension ResourceMapExtentions<T extends Resource> on ResourceMap<T> {
  List<T> toResourceList() {
    var list = values.toList();
    if (T is NamedResource) list.cast<NamedResource>().sort((NamedResource a, NamedResource b) => a.name.compareTo(b.name));
    return list;
  }

  void addResourceList(Iterable<T> list) => addAll({for (var s in list) s.id: s});
}
