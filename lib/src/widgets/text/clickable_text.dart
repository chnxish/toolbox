import 'package:flutter/material.dart';

import 'package:toolbox/src/utils/launch_url.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    required this.url,
    this.textStyle,
  });

  final String text;
  final String url;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(url),
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(text, style: textStyle),
    );
  }
}
