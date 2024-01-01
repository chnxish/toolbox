import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toolbox/src/constant/constant.dart';

import 'package:toolbox/src/theme/theme.dart';

class Alert extends StatelessWidget {
  const Alert({super.key, required this.text, required this.isVisible});

  final String text;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Visibility(
      visible: isVisible,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: theme.extension<ExtensionColors>()!.gradientGrey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                '${Constant.imagePath}warn.svg',
                width: 16.0,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 2.0),
              Text(
                text,
                style: theme.textTheme.labelSmall!.copyWith(
                    color: theme.extension<ExtensionColors>()!.textGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
