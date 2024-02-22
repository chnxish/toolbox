import 'package:flutter/material.dart';

import 'package:toolbox/src/widgets/scroll_behavior/window_scroll_behavior.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_cell.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_item.dart';

class Sidebar extends StatelessWidget {
  Sidebar({
    super.key,
    required this.sidebarController,
    this.items = const [],
  });

  final SidebarController sidebarController;
  final ScrollController scrollController = ScrollController();
  final List<SidebarItem> items;

  void _onItemSelected(SidebarItem item, int index) {
    item.onTap?.call();
    sidebarController.selectIndex(index);
  }

  void _onItemLongPressSelected(SidebarItem item, int index) {
    item.onLongPress?.call();
  }

  void _onItemSecondaryTapSelected(SidebarItem item, int index) {
    item.onSecondaryTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sidebarController,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: ScrollConfiguration(
            behavior: WindowScrollBehavior(),
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4.0),
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SidebarCell(
                    item: item,
                    selected: sidebarController.selectedIndex == index,
                    onTap: () => _onItemSelected(item, index),
                    onLongPress: () => _onItemLongPressSelected(item, index),
                    onSecondaryTap: () =>
                        _onItemSecondaryTapSelected(item, index),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
