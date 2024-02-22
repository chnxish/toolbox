import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/button/window_text_button.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({
    super.key,
    required this.title,
    required this.text,
    required this.onPressed,
    this.width = 380.0,
    this.height = 140.0,
  });

  final String title;
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;

    return AnimatedPadding(
      duration: Duration.zero,
      padding: EdgeInsets.symmetric(
        horizontal: (screenSize.width - width) / 2,
        vertical: (screenSize.height - height) / 2,
      ),
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Container(
          decoration: BoxDecoration(
            gradient: theme.extension<ExtensionColors>()!.gradientGrey,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 22.0,
                  top: 9.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        '${Constant.imagePath}success.svg',
                        width: 18.0,
                        colorFilter: const ColorFilter.mode(
                          CustomColors.accent02,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      SelectableText(
                        title,
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30.0,
                  top: 38.0,
                  child: LimitedBox(
                    maxWidth: 296.0,
                    child: SelectableText(
                      text,
                      style:
                          theme.textTheme.bodySmall!.copyWith(fontSize: 10.0),
                    ),
                  ),
                ),
                Positioned(
                  right: 15.0,
                  bottom: 8.0,
                  child: WindowTextButton(
                    width: 30.0,
                    height: 18.0,
                    text: 'OK',
                    textStyle: theme.textTheme.labelSmall!
                        .copyWith(color: CustomColors.accent02),
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
