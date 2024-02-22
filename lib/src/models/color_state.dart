import 'package:flutter/material.dart';

class ColorState {
  ColorState({
    required this.normal,
    required this.mouseOver,
    required this.mouseDown,
  });

  Color normal;
  Color mouseOver;
  Color mouseDown;

  factory ColorState.same(Color color) {
    return ColorState(
      normal: color,
      mouseOver: color,
      mouseDown: color,
    );
  }

  factory ColorState.transparent() {
    return ColorState.same(Colors.transparent);
  }
}
