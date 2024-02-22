import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/button/user_menu_item.dart';
import 'package:toolbox/src/widgets/button/window_icon_button.dart';

class UserMenuButton extends StatefulWidget {
  const UserMenuButton({
    super.key,
    this.avatar = '',
    this.username = '',
    this.userMenuItems = const [],
  });

  final String avatar;
  final String username;
  final List<UserMenuItem> userMenuItems;

  @override
  State<UserMenuButton> createState() => _UserMenuButtonState();
}

class _UserMenuButtonState extends State<UserMenuButton> {
  final MenuController _menuController = MenuController();
  bool _isHovering = false;
  bool _isPressed = false;

  void _onEntered({required bool hovered}) {
    setState(() => _isHovering = hovered);
  }

  void _onActive({required bool pressed}) {
    setState(() => _isPressed = pressed);
  }

  void _toggleMenu() {
    if (_menuController.isOpen) {
      _menuController.close();
    } else {
      _menuController.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    ColorState buttonBackgroundColors =
        theme.extension<ExtensionColors>()!.buttonBackgroundColors;
    Color buttonBackgroundColor = buttonBackgroundColors.normal;
    MenuStyle menuStyle = MenuStyle(
      alignment: Alignment.bottomRight,
      elevation: const MaterialStatePropertyAll(1.0),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      side: MaterialStatePropertyAll(
        BorderSide(
          width: 1.0,
          color: theme
              .extension<ExtensionColors>()!
              .backgroundGrey
              .withOpacity(0.5),
        ),
      ),
    );

    if (_isHovering) {
      buttonBackgroundColor = buttonBackgroundColors.mouseOver;
    }
    if (_isPressed) {
      buttonBackgroundColor = buttonBackgroundColors.mouseDown;
    }

    return MenuAnchor(
      controller: _menuController,
      alignmentOffset: const Offset(-122.0, 8.0),
      style: menuStyle,
      menuChildren: widget.userMenuItems.map((item) {
        return Container(
          color: theme.scaffoldBackgroundColor,
          child: WindowIconButton(
            width: 122.0,
            height: 32.0,
            backgroundColors: ColorState(
              normal: Colors.transparent,
              mouseOver: theme
                  .extension<ExtensionColors>()!
                  .backgroundGrey
                  .withOpacity(0.9),
              mouseDown: theme
                  .extension<ExtensionColors>()!
                  .backgroundGrey
                  .withOpacity(0.9),
            ),
            onPressed: () {
              item.onTap!();
              _toggleMenu();
            },
            iconWidget: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 32.0,
                  height: 32.0,
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    item.iconPath,
                    width: 16.0,
                    colorFilter: ColorFilter.mode(
                      theme.extension<ExtensionColors>()!.textGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Container(
                  width: 90.0,
                  height: 32.0,
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: Text(
                    item.label,
                    style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      child: MouseRegion(
        onExit: (value) => _onEntered(hovered: false),
        onHover: (value) => _onEntered(hovered: true),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _onActive(pressed: true),
          onTapCancel: () => _onActive(pressed: false),
          onTapUp: (_) => _onActive(pressed: false),
          onTap: _toggleMenu,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: widget.avatar.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.avatar,
                            width: 24.0,
                          ),
                        )
                      : Container(),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4.0, right: 6.0),
                  child: Text(
                    widget.username,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.extension<ExtensionColors>()!.textGrey),
                  ),
                ),
                SvgPicture.asset(
                  '${Constant.imagePath}down.svg',
                  width: 16.0,
                  colorFilter: ColorFilter.mode(
                    theme.extension<ExtensionColors>()!.buttonIconColors.normal,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
