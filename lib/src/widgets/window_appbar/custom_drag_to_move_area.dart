import 'package:flutter/material.dart';

import 'package:window_manager/window_manager.dart';

class CustomDragToMoveArea extends StatelessWidget {
  const CustomDragToMoveArea({
    Key? key,
    this.child,
    this.onDoubleTap,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      onDoubleTap: onDoubleTap ??
          () async {
            bool isMaximized = await windowManager.isMaximized();
            if (!isMaximized) {
              windowManager.maximize();
            } else {
              windowManager.unmaximize();
            }
          },
      child: child,
    );
  }
}
