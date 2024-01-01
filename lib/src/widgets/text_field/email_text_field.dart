import 'package:flutter/material.dart';

import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/validate.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late final FocusNode _focusNode;
  bool _isFocus = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      final bool hasFocus = _focusNode.hasFocus;
      if (!hasFocus) {
        _validateEmailInput();
      }
      setState(() {
        _isFocus = hasFocus;
      });
    });
  }

  void _validateEmailInput() {
    String value = widget.controller.text;
    setState(() {
      errorText = validateEmail(value);
    });
  }

  Widget _buildErrorText(TextStyle? textStyle) {
    return (errorText != null && _isFocus == false)
        ? SizedBox(width: 300.0, child: Text(errorText!, style: textStyle))
        : Container();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        Container(
          width: 320.0,
          height: 52.0,
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _isFocus
                  ? CustomColors.accent02
                  : theme.extension<ExtensionColors>()!.backgroundGrey,
              width: 2.0,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(22.0, 0.0, 20.0, 0.0),
              hintText: 'Email',
              hintStyle: theme.textTheme.labelLarge!.copyWith(
                  color: theme.extension<ExtensionColors>()!.textGrey),
              border: InputBorder.none,
            ),
            style: theme.textTheme.labelLarge,
            onEditingComplete: () => _focusNode.unfocus(),
          ),
        ),
        _buildErrorText(theme.textTheme.bodySmall!
            .copyWith(color: theme.colorScheme.error)),
      ],
    );
  }
}
