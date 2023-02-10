abstract class GraphContainer<T> {
  void addNode(Node<T> n);

  List<Node<T>> getChildren(Node<T> n);

  Node<T>? getParent(Node<T> n);
}

class IndexedForest<TValue, TId> implements GraphContainer<TValue> {
  IndexedForest({required this.id, List<TValue>? initValues}) {
    if (initValues != null) {
      _index = {for (TValue value in initValues) id(value): Node(this, value: value)};
      for (var node in _index.values) {
        node.value
      }
      _roots = _index.values.where((e) => e.parent == null).toList();
    }
  }

  List<Node<TValue>> _roots = [];
  Map<TId, Node<TValue>> _index = {};

  TId Function(TValue) id;

  @override
  void addNode(Node<TValue> n) {
    if (n.parent == null) _roots.add(n);
    _index[id(n.value)] = n;
  }

  @override
  List<Node<TValue>> getChildren(Node<TValue> n) {
    // TODO: implement getChildren
    throw UnimplementedError();
  }

  @override
  Node<TValue>? getParent(Node<TValue> n) {
    // TODO: implement getParent
    throw UnimplementedError();
  }
}

class Node<T> {
  Node(
    this._container, {
    this.parent,
    this.children = const [],
    required this.value,
  });

  final GraphContainer _container;
  Node<T>? parent;

  List<Node<T>> children;
  T value;

  void addChild(Node<T> child) {
    child.parent = this;
    _container.addNode(child);
    children.add(child);
  }

  void addChildWithValue(T value) {
    var child = Node(_container, value: value);
    addChild(child);
  }
}
