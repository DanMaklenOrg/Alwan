extension ListExtensions<T> on List<T> {
  /// Similar to [operator[]] but the index wraps around list boundaries.
  /// For example, returns [List.last] if [i] = -1
  T atWrap(int i) {
    return this[i % length];
  }
}
