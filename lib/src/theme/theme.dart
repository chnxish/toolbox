import 'package:flutter/material.dart';

import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/models/color_state.dart';

@immutable
class ExtensionColors extends ThemeExtension<ExtensionColors> {
  const ExtensionColors({
    required this.text,
    required this.textGrey,
    required this.backgroundGrey,
    required this.gradientGreen,
    required this.gradientGrey,
    required this.buttonBackgroundColors,
    required this.buttonIconColors,
    required this.closeButtonBackgroundColors,
    required this.closeButtonIconColors,
  });

  final Color text;
  final Color textGrey;
  final Color backgroundGrey;
  final LinearGradient gradientGreen;
  final LinearGradient gradientGrey;
  final ColorState buttonBackgroundColors;
  final ColorState buttonIconColors;
  final ColorState closeButtonBackgroundColors;
  final ColorState closeButtonIconColors;

  @override
  ExtensionColors copyWith({
    Color? text,
    Color? textGrey,
    Color? backgroundGrey,
    LinearGradient? gradientGreen,
    LinearGradient? gradientGrey,
    final ColorState? buttonBackgroundColors,
    final ColorState? buttonIconColors,
    final ColorState? closeButtonBackgroundColors,
    final ColorState? closeButtonIconColors,
  }) {
    return ExtensionColors(
      text: text ?? this.text,
      textGrey: textGrey ?? this.textGrey,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      gradientGreen: gradientGreen ?? this.gradientGreen,
      gradientGrey: gradientGrey ?? this.gradientGrey,
      buttonBackgroundColors:
          buttonBackgroundColors ?? this.buttonBackgroundColors,
      buttonIconColors: buttonIconColors ?? this.buttonIconColors,
      closeButtonBackgroundColors:
          closeButtonBackgroundColors ?? this.closeButtonBackgroundColors,
      closeButtonIconColors:
          closeButtonIconColors ?? this.closeButtonIconColors,
    );
  }

  @override
  ExtensionColors lerp(ExtensionColors? other, double t) {
    if (other is! ExtensionColors) {
      return this;
    }
    return ExtensionColors(
      text: Color.lerp(text, other.text, t)!,
      textGrey: Color.lerp(textGrey, other.textGrey, t)!,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t)!,
      gradientGreen:
          LinearGradient.lerp(gradientGreen, other.gradientGreen, t)!,
      gradientGrey: LinearGradient.lerp(gradientGrey, other.gradientGrey, t)!,
      buttonBackgroundColors: ColorState(
        normal: Color.lerp(buttonBackgroundColors.normal,
            other.buttonBackgroundColors.normal, t)!,
        mouseOver: Color.lerp(buttonBackgroundColors.mouseOver,
            other.buttonBackgroundColors.mouseOver, t)!,
        mouseDown: Color.lerp(buttonBackgroundColors.mouseDown,
            other.buttonBackgroundColors.mouseDown, t)!,
      ),
      buttonIconColors: ColorState(
        normal: Color.lerp(
            buttonIconColors.normal, other.buttonIconColors.normal, t)!,
        mouseOver: Color.lerp(
            buttonIconColors.mouseOver, other.buttonIconColors.mouseOver, t)!,
        mouseDown: Color.lerp(
            buttonIconColors.mouseDown, other.buttonIconColors.mouseDown, t)!,
      ),
      closeButtonBackgroundColors: ColorState(
        normal: Color.lerp(closeButtonBackgroundColors.normal,
            other.closeButtonBackgroundColors.normal, t)!,
        mouseOver: Color.lerp(closeButtonBackgroundColors.mouseOver,
            other.closeButtonBackgroundColors.mouseOver, t)!,
        mouseDown: Color.lerp(closeButtonBackgroundColors.mouseDown,
            other.closeButtonBackgroundColors.mouseDown, t)!,
      ),
      closeButtonIconColors: ColorState(
        normal: Color.lerp(closeButtonIconColors.normal,
            other.closeButtonIconColors.normal, t)!,
        mouseOver: Color.lerp(closeButtonIconColors.mouseOver,
            other.closeButtonIconColors.mouseOver, t)!,
        mouseDown: Color.lerp(closeButtonIconColors.mouseDown,
            other.closeButtonIconColors.mouseDown, t)!,
      ),
    );
  }
}

const TextTheme customTextTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),
  displayMedium: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
  displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
  headlineLarge: TextStyle(fontSize: 36.0),
  headlineMedium: TextStyle(fontSize: 30.0),
  headlineSmall: TextStyle(fontSize: 24.0),
  titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  labelLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
  bodyLarge: TextStyle(fontSize: 16.0),
  bodyMedium: TextStyle(fontSize: 14.0),
  bodySmall: TextStyle(fontSize: 12.0),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'SourceHanSans',
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: CustomColors.primary,
        secondary: CustomColors.secondary,
      ),
  scaffoldBackgroundColor: CustomColors.backgroundLight,
  textTheme: customTextTheme.apply(
    displayColor: CustomColors.textBlack,
    bodyColor: CustomColors.textBlack,
  ),
).copyWith(
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    thumbColor:
        MaterialStateProperty.all(CustomColors.scrollbarBackgroundLight),
    radius: const Radius.circular(2.0),
    thickness: MaterialStateProperty.all(4.0),
  ),
  extensions: <ThemeExtension<dynamic>>[
    ExtensionColors(
      text: CustomColors.textBlack,
      textGrey: CustomColors.textDarkGrey,
      backgroundGrey: CustomColors.backgroundLightGrey,
      gradientGreen: CustomColors.gradientLightGreen,
      gradientGrey: CustomColors.gradientLightGrey,
      buttonBackgroundColors: CustomColors.buttonBackgroundLight,
      buttonIconColors: CustomColors.buttonIconLight,
      closeButtonBackgroundColors: CustomColors.closeButtonBackgroundLight,
      closeButtonIconColors: CustomColors.closeButtonIconLight,
    ),
  ],
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'SourceHanSans',
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: CustomColors.primary,
        secondary: CustomColors.secondary,
      ),
  scaffoldBackgroundColor: CustomColors.backgroundDark,
  textTheme: customTextTheme.apply(
    displayColor: CustomColors.textWhite,
    bodyColor: CustomColors.textWhite,
  ),
).copyWith(
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(CustomColors.scrollbarBackgroundDark),
    radius: const Radius.circular(2.0),
    thickness: MaterialStateProperty.all(4.0),
  ),
  extensions: <ThemeExtension<dynamic>>[
    ExtensionColors(
      text: CustomColors.textWhite,
      textGrey: CustomColors.textLightGrey,
      backgroundGrey: CustomColors.backgroundDarkGrey,
      gradientGreen: CustomColors.gradientDarkGreen,
      gradientGrey: CustomColors.gradientDarkGrey,
      buttonBackgroundColors: CustomColors.buttonBackgroundDark,
      buttonIconColors: CustomColors.buttonIconDark,
      closeButtonBackgroundColors: CustomColors.closeButtonBackgroundDark,
      closeButtonIconColors: CustomColors.closeButtonIconDark,
    ),
  ],
);
