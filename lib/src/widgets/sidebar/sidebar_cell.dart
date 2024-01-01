import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_item.dart';

class SidebarCell extends StatefulWidget {
  const SidebarCell({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
    required this.onSecondaryTap,
  });

  final bool selected;
  final SidebarItem item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onSecondaryTap;

  @override
  State<SidebarCell> createState() => _SidebarCellState();
}

class _SidebarCellState extends State<SidebarCell> {
  bool _hovered = false;

  void _onEnteredCellZone() {
    setState(() => _hovered = true);
  }

  void _onExitCellZone() {
    setState(() => _hovered = false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => _onEnteredCellZone(),
      onExit: (_) => _onExitCellZone(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onSecondaryTap: widget.onSecondaryTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: _hovered || widget.selected
                ? theme
                    .extension<ExtensionColors>()!
                    .backgroundGrey
                    .withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                widget.selected
                    ? widget.item.boldIconPath
                    : widget.item.outlineIconPath,
                width: 24.0,
                colorFilter: ColorFilter.mode(
                  widget.selected
                      ? theme.colorScheme.primary
                      : theme.extension<ExtensionColors>()!.textGrey,
                  BlendMode.srcIn,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 2.0, 0.0, 2.0),
                child: Text(
                  widget.item.label,
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: widget.selected
                        ? theme.colorScheme.primary
                        : theme.extension<ExtensionColors>()!.textGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
