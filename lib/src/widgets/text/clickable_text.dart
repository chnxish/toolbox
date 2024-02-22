import 'package:flutter/material.dart';

import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/utils/launch_url.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    required this.path,
    this.isInternalRoute = true,
    this.textStyle,
  });

  final String text;
  final String path;
  final bool isInternalRoute;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isInternalRoute) {
          Application.router.navigateTo(context, path);
        } else {
          launchUrl(path);
        }
      },
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(text, style: textStyle),
    );
  }
}
