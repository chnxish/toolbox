import 'package:flutter/material.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/button/window_icon_button.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/custom_colors.dart';

const kLoginPageAppbarHeight = 32.0;

class LoginPageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const LoginPageAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kLoginPageAppbarHeight);

  @override
  State<LoginPageAppbar> createState() => _LoginPageAppbarState();
}

class _LoginPageAppbarState extends State<LoginPageAppbar> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PreferredSize(
      preferredSize: const Size.fromHeight(kLoginPageAppbarHeight),
      child: DragToMoveArea(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(color: CustomColors.accent01),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: WindowIconButton.close(
                      backgroundColors: theme
                          .extension<ExtensionColors>()!
                          .closeButtonBackgroundColors,
                      iconColors: theme
                          .extension<ExtensionColors>()!
                          .closeButtonIconColors,
                      onPressed: () => windowManager.close(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
