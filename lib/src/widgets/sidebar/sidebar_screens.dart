import 'package:flutter/material.dart';

import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';

class SidebarScreens extends StatelessWidget {
  const SidebarScreens({
    super.key,
    required this.controller,
    this.items = const [],
  });

  final SidebarController controller;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return items[controller.selectedIndex];
      },
    );
  }
}
