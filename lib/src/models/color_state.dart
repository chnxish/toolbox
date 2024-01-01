import 'package:flutter/material.dart';

class ColorState {
  ColorState({
    required this.normal,
    required this.mouseOver,
    required this.mouseDown,
  });

  factory ColorState.transparent() {
    return ColorState(
      normal: Colors.transparent,
      mouseOver: Colors.transparent,
      mouseDown: Colors.transparent,
    );
  }

  Color normal;
  Color mouseOver;
  Color mouseDown;
}
