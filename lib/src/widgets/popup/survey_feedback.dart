import 'package:flutter/material.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/custom_colors.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/launch_url.dart';
import 'package:toolbox/src/widgets/button/window_icon_button.dart';
import 'package:toolbox/src/widgets/button/window_text_button.dart';

class SurveyFeedback extends StatefulWidget {
  const SurveyFeedback({super.key});

  @override
  State<SurveyFeedback> createState() => _SurveyFeedbackState();
}

class _SurveyFeedbackState extends State<SurveyFeedback> {
  bool _isVisible = true;

  void _close() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Visibility(
      visible: _isVisible,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: 154.0,
        height: 152.0,
        decoration: BoxDecoration(
          gradient: theme.extension<ExtensionColors>()!.gradientGreen,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 20.0,
              top: 18.0,
              child: SizedBox(
                width: 84.0,
                child: SelectableText(
                  'Coming Soon: More Powerful Features',
                  style: theme.textTheme.labelMedium!
                      .copyWith(color: CustomColors.textWhite),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: WindowIconButton.close(
                backgroundColors:
                    ColorState.same(theme.scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(12.0),
                iconColors:
                    ColorState.same(theme.extension<ExtensionColors>()!.text),
                onPressed: _close,
              ),
            ),
            Positioned(
              left: 17.0,
              bottom: 14.0,
              child: WindowTextButton(
                width: 120.0,
                height: 26.0,
                backgroundColors:
                    ColorState.same(Colors.white.withOpacity(0.9)),
                borderRadius: BorderRadius.circular(8.0),
                text: 'Tell about your idea',
                textStyle: theme.textTheme.labelSmall!
                    .copyWith(color: CustomColors.textBlack),
                onPressed: () => launchUrl('mailto:$Constant.emailUrl'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
