import 'package:flutter/material.dart';

extension AxisExtension on Axis {
  Axis get flip => flipAxis(this);
}

extension BoolExtensions on bool? {
  int toInt() {
    return this ?? false ? 1 : 0;
  }
}
