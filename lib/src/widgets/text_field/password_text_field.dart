import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/validate.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late final FocusNode _focusNode;
  bool _isFocus = false;
  bool _isObscure = true;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      final bool hasFocus = _focusNode.hasFocus;
      if (!hasFocus) {
        _validatePasswordInput();
      }
      setState(() {
        _isFocus = hasFocus;
      });
    });
  }

  void _validatePasswordInput() {
    String value = widget.controller.text;
    setState(() {
      errorText = validatePassword(value);
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
            obscureText: _isObscure,
            style: theme.textTheme.labelLarge!
                .copyWith(letterSpacing: _isObscure ? -7.0 : 0.0),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 22.0),
              hintText: 'Password',
              hintStyle: theme.textTheme.labelLarge!.copyWith(
                  color: theme.extension<ExtensionColors>()!.textGrey),
              border: InputBorder.none,
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(4.0, 0.0, 20.0, 0.0),
                child: GestureDetector(
                  child: SvgPicture.asset(
                    _isObscure
                        ? '${Constant.imagePath}show.svg'
                        : '${Constant.imagePath}hide.svg',
                    width: 24.0,
                    colorFilter: ColorFilter.mode(
                      theme.extension<ExtensionColors>()!.text,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              suffixIconConstraints: const BoxConstraints(maxWidth: 48.0),
            ),
          ),
        ),
        _buildErrorText(theme.textTheme.bodySmall!
            .copyWith(color: theme.colorScheme.error)),
      ],
    );
  }
}
