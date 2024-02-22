import 'package:flutter/material.dart';

import 'package:toolbox/src/models/color_state.dart';

final class CustomColors {
  static const Color primary = Color(0xFF345DFF);
  static const Color secondary = Color(0xFFFBAC25);
  static const Color accent01 = Color(0xFF6C4DD3);
  static const Color accent02 = Color(0xFF3F7CFF);
  static const Color accent03 = Color(0xFFFF98E5);
  static const Color textBlack = Color(0xFF11141D);
  static const Color textDarkGrey = Color(0xFF4D4D4D);
  static const Color textWhite = Color(0xFFFDFDFD);
  static const Color textLightGrey = Color(0xFFD0D0D0);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundLightGrey = Color(0xFFE4E4E4);
  static const Color backgroundDark = Color(0xFF1B1D11);
  static const Color backgroundDarkGrey = Color(0xFF373A43);
  static const LinearGradient gradientLightGrey = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x66D1CFCF), Color(0x84D1CFCF), Color(0x5FD1CFCF)],
  );
  static const LinearGradient gradientDarkGrey = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x38595858), Color(0x2F595858), Color(0x39595858)],
  );
  static const LinearGradient gradientLightGreen = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xF10BC248), Color(0x7729EF0E)]);
  static const LinearGradient gradientDarkGreen = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xB108C547), Color(0xFF1CFF67)]);
  static ColorState buttonBackgroundLight = ColorState(
    normal: Colors.transparent,
    mouseOver: const Color(0xFFE9E9E9),
    mouseDown: const Color(0xFFEDEDED),
  );
  static ColorState buttonIconLight = ColorState(
    normal: const Color(0xFF4E4E4E),
    mouseOver: const Color(0xFF4E4E4E),
    mouseDown: const Color(0xFF7F7F7F),
  );
  static ColorState closeButtonBackgroundLight = ColorState(
    normal: Colors.transparent,
    mouseOver: const Color(0xFFC42B1C),
    mouseDown: const Color(0xFFC83C31),
  );
  static ColorState closeButtonIconLight = ColorState(
    normal: const Color(0xFF4E4E4E),
    mouseOver: const Color(0xFFFFFFFF),
    mouseDown: const Color(0xFFFFFFFF),
  );
  static ColorState buttonBackgroundDark = ColorState(
    normal: Colors.transparent,
    mouseOver: const Color(0xFF2D2D2D),
    mouseDown: const Color(0xFF292929),
  );
  static ColorState buttonIconDark = ColorState(
    normal: const Color(0xFFFFFFFF),
    mouseOver: const Color(0xFFFFFFFF),
    mouseDown: const Color(0xFFB9B9B9),
  );
  static ColorState closeButtonBackgroundDark = ColorState(
    normal: Colors.transparent,
    mouseOver: const Color(0xFFC42B1C),
    mouseDown: const Color(0xFFB3271C),
  );
  static ColorState closeButtonIconDark = ColorState(
    normal: const Color(0xFFFFFFFF),
    mouseOver: const Color(0xFFFFFFFF),
    mouseDown: const Color(0xFFD6D6D6),
  );
  static const Color scrollbarBackgroundLight = Color(0xFFE2E2E9);
  static const Color scrollbarBackgroundDark = Color(0xFF414145);
}
