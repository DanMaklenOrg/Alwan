import 'game_models.dart';

typedef ResourceMap<T extends PikaResource> = Map<ResourceId, T>;

extension ResourceMapExtentions<T extends PikaResource> on ResourceMap<T> {
  List<T> toResourceList() {
    var list = values.toList();
    list.sort();
    return list;
  }

  void addResourceList(Iterable<T> list) => addAll({for (var s in list) s.id: s});
}
