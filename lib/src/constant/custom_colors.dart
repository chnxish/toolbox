import 'package:flutter/material.dart';

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
  static const LinearGradient gradientLightGreen = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xF10BC248), Color(0x7729EF0E)]);
  static const LinearGradient gradientDarkGreen = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xB108C547), Color(0xFF1CFF67)]);
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
}
