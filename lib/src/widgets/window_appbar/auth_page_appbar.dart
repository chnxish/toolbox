import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/button/window_icon_button.dart';
import 'package:toolbox/src/widgets/window_appbar/custom_drag_to_move_area.dart';

const double kAuthPageAppbarHeight = 32.0;

class AuthPageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const AuthPageAppbar({super.key, required this.leftSideBackground});

  final Color leftSideBackground;

  @override
  Size get preferredSize => const Size.fromHeight(kAuthPageAppbarHeight);

  @override
  State<AuthPageAppbar> createState() => _AuthPageAppbarState();
}

class _AuthPageAppbarState extends State<AuthPageAppbar> with WindowListener {
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
      preferredSize: const Size.fromHeight(kAuthPageAppbarHeight),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CustomDragToMoveArea(
              onDoubleTap: () {},
              child: Container(color: widget.leftSideBackground),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                CustomDragToMoveArea(onDoubleTap: () {}),
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
    );
  }
}
