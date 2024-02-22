import 'package:flutter/material.dart';

class CheckboxWithText extends StatelessWidget {
  const CheckboxWithText({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.text,
    this.backgroundColor,
    this.sideColor = const Color(0xFF000000),
    this.textStyle,
  });

  final bool isChecked;
  final VoidCallback onChanged;
  final String text;
  final Color? backgroundColor;
  final Color sideColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 16.0,
          child: Checkbox(
            value: isChecked,
            activeColor: backgroundColor,
            side: BorderSide(width: 2.0, color: sideColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            splashRadius: 0.0,
            onChanged: (_) => onChanged(),
          ),
        ),
        const SizedBox(width: 7.0),
        SelectableText(text, style: textStyle),
      ],
    );
  }
}
