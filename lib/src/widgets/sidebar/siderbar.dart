import 'package:flutter/material.dart';

import 'package:toolbox/src/widgets/sidebar/sidebar_cell.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.controller,
    this.items = const [],
  });

  final SidebarController controller;
  final List<SidebarItem> items;

  void _onItemSelected(SidebarItem item, int index) {
    item.onTap?.call();
    controller.selectIndex(index);
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
      animation: controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4.0),
            itemBuilder: (context, index) {
              final item = items[index];
              return SidebarCell(
                item: item,
                selected: controller.selectedIndex == index,
                onTap: () => _onItemSelected(item, index),
                onLongPress: () => _onItemLongPressSelected(item, index),
                onSecondaryTap: () => _onItemSecondaryTapSelected(item, index),
              );
            },
          ),
        );
      },
    );
  }
}
