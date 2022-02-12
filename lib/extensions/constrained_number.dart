class ConstrainedNumber<T extends num> {
  ConstrainedNumber(
    T val, {
    required this.min,
    required this.max,
    this.clamp = false,
  }) {
    value = val;
  }

  late T _value;
  final T max;
  final T min;
  final bool clamp;

  T get value => _value;

  set value(T val) {
    if (clamp) {
      val.clamp(min, max) as T;
    } else if (val < min || val > max) {
      throw RangeError.value(val);
    } else {
      _value = val;
    }
  }
}
