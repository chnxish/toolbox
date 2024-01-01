import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/models/color_state.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/launch_url.dart';

class UserMenuButton extends StatefulWidget {
  const UserMenuButton({super.key});

  @override
  State<UserMenuButton> createState() => _UserMenuButtonState();
}

class _UserMenuButtonState extends State<UserMenuButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  void _onEntered({required bool hovered}) {
    setState(() => _isHovering = hovered);
  }

  void _onActive({required bool pressed}) {
    setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    final String username =
        Provider.of<UserProvider>(context, listen: false).username;
    final String avatar =
        Provider.of<UserProvider>(context, listen: false).avatar;
    final ThemeData theme = Theme.of(context);
    ColorState backgroundColors =
        theme.extension<ExtensionColors>()!.buttonBackgroundColors;
    Color backgroundColor = backgroundColors.normal;
    ButtonStyle menuItemButtonStyle = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return theme.extension<ExtensionColors>()!.backgroundGrey;
        }
        if (states.contains(MaterialState.pressed)) {
          return theme.extension<ExtensionColors>()!.backgroundGrey;
        }
        return theme.scaffoldBackgroundColor;
      }),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );

    if (_isHovering) {
      backgroundColor = backgroundColors.mouseOver;
    }
    if (_isPressed) {
      backgroundColor = backgroundColors.mouseDown;
    }

    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return MouseRegion(
          onExit: (value) => _onEntered(hovered: false),
          onHover: (value) => _onEntered(hovered: true),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => _onActive(pressed: true),
            onTapCancel: () => _onActive(pressed: false),
            onTapUp: (_) => _onActive(pressed: false),
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: Container(
              width: 110.0,
              height: 32.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: backgroundColor,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 7.0, right: 4.0),
                    child: avatar.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              avatar,
                              width: 24.0,
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4.0, right: 2.0),
                    child: Text(
                      username,
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.extension<ExtensionColors>()!.textGrey),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      '${Constant.imagePath}down.svg',
                      width: 16.0,
                      colorFilter: ColorFilter.mode(
                          theme
                              .extension<ExtensionColors>()!
                              .buttonIconColors
                              .normal,
                          BlendMode.srcIn),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      alignmentOffset: const Offset(-12.0, 8.0),
      menuChildren: [
        MenuItemButton(
          style: menuItemButtonStyle,
          onPressed: () => launchUrl(Constant.frontendUrl),
          child: SizedBox(
            width: 106.0,
            height: 32.0,
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  '${Constant.imagePath}user-settings.svg',
                  width: 16.0,
                  colorFilter: ColorFilter.mode(
                    theme.extension<ExtensionColors>()!.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  'User Settings',
                  style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.extension<ExtensionColors>()!.textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        MenuItemButton(
          style: menuItemButtonStyle,
          onPressed: () => Application.router.navigateTo(context, Routes.login),
          child: SizedBox(
            width: 106.0,
            height: 32.0,
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  '${Constant.imagePath}logout.svg',
                  width: 16.0,
                  colorFilter: ColorFilter.mode(
                    theme.extension<ExtensionColors>()!.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Logout',
                  style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.extension<ExtensionColors>()!.textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
