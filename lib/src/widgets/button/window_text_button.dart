import 'package:flutter/material.dart';

import 'package:toolbox/src/models/color_state.dart';

class WindowTextButton extends StatefulWidget {
  const WindowTextButton({
    super.key,
    this.width = 200.0,
    this.height = 40.0,
    this.backgroundColors,
    this.borderRadius,
    this.text = '',
    this.textStyle,
    this.onPressed,
  });

  final double width;
  final double height;
  final ColorState? backgroundColors;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  @override
  State<WindowTextButton> createState() => _WindowTextButtonState();
}

class _WindowTextButtonState extends State<WindowTextButton> {
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
    ColorState backgroundColors =
        widget.backgroundColors ?? ColorState.transparent();
    Color backgroundColor = backgroundColors.normal;

    if (_isHovering) {
      backgroundColor = backgroundColors.mouseOver;
    }
    if (_isPressed) {
      backgroundColor = backgroundColors.mouseDown;
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
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
