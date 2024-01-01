import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/models/color_state.dart';

class WindowIconButton extends StatefulWidget {
  const WindowIconButton({
    super.key,
    this.width = 24.0,
    this.height = 24.0,
    this.backgroundColors,
    this.borderRadius,
    this.assertName,
    this.iconColors,
    this.iconWidget,
    this.onPressed,
  }) : assert(
          (assertName != null || iconWidget != null) &&
              (assertName == null || iconWidget == null),
          'You can create WindowIconButton with String? assertName or with Widget? iconWidget',
        );

  final double width;
  final double height;
  final ColorState? backgroundColors;
  final BorderRadiusGeometry? borderRadius;
  final String? assertName;
  final ColorState? iconColors;
  final Widget? iconWidget;
  final VoidCallback? onPressed;

  factory WindowIconButton.down({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}down.svg',
      backgroundColors: backgroundColors,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.notification({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}notification.svg',
      backgroundColors: backgroundColors,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.setting({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}setting.svg',
      backgroundColors: backgroundColors,
      borderRadius: borderRadius,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.minimize({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}minimize.svg',
      backgroundColors: backgroundColors,
      borderRadius: borderRadius,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.maximize({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}maximize.svg',
      backgroundColors: backgroundColors,
      borderRadius: borderRadius,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.unmaximize({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}unmaximize.svg',
      backgroundColors: backgroundColors,
      borderRadius: borderRadius,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  factory WindowIconButton.close({
    ColorState? backgroundColors,
    BorderRadiusGeometry? borderRadius,
    ColorState? iconColors,
    VoidCallback? onPressed,
  }) {
    return WindowIconButton(
      assertName: '${Constant.imagePath}close.svg',
      backgroundColors: backgroundColors,
      borderRadius: borderRadius,
      iconColors: iconColors,
      onPressed: onPressed,
    );
  }

  @override
  State<WindowIconButton> createState() => _WindowIconButtonState();
}

class _WindowIconButtonState extends State<WindowIconButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  void _onEntered({required bool hovered}) {
    setState(() => _isHovering = hovered);
  }

  void _onActive({required bool pressed}) {
    setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget;
    ColorState backgroundColors =
        widget.backgroundColors ?? ColorState.transparent();
    ColorState iconColors = widget.iconColors ?? ColorState.transparent();
    Color backgroundColor = backgroundColors.normal;
    Color iconColor = iconColors.normal;

    if (_isHovering) {
      backgroundColor = backgroundColors.mouseOver;
      iconColor = iconColors.mouseOver;
    }
    if (_isPressed) {
      backgroundColor = backgroundColors.mouseDown;
      iconColor = iconColors.mouseDown;
    }

    if (widget.assertName != null) {
      childWidget = SvgPicture.asset(
        widget.assertName!,
        width: widget.width - 8.0,
        height: widget.height - 8.0,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    } else if (widget.iconWidget != null) {
      childWidget = widget.iconWidget!;
    } else {
      childWidget = Container();
    }

    return MouseRegion(
      onExit: (value) => _onEntered(hovered: false),
      onHover: (value) => _onEntered(hovered: true),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _onActive(pressed: true),
        onTapCancel: () => _onActive(pressed: false),
        onTapUp: (_) => _onActive(pressed: false),
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Center(
            child: childWidget,
          ),
        ),
      ),
    );
  }
}
