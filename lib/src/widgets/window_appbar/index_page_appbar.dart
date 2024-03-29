import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/constant/service_url.dart';
import 'package:toolbox/src/models/user.dart';
import 'package:toolbox/src/provider/theme_provider.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/button/user_menu_item.dart';
import 'package:toolbox/src/widgets/button/user_menu_button.dart';
import 'package:toolbox/src/widgets/button/window_icon_button.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';
import 'package:toolbox/src/widgets/window_appbar/custom_drag_to_move_area.dart';

const double kIndexPageAppbarHeight = 60;

class IndexPageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const IndexPageAppbar({super.key, required this.sidebarController});

  final SidebarController sidebarController;

  @override
  Size get preferredSize => const Size.fromHeight(kIndexPageAppbarHeight);

  @override
  State<IndexPageAppbar> createState() => _IndexPageAppbarState();
}

class _IndexPageAppbarState extends State<IndexPageAppbar> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void onWindowMaximize() {
    setState(() {});
  }

  @override
  void onWindowUnmaximize() {
    setState(() {});
  }

  void _logout() {
    DioService.post(ServiceUrl.logout, successCallBack: (dataMap) {
      bool isRemember =
          Provider.of<UserProvider>(context, listen: false).isRemember;
      User user = Provider.of<UserProvider>(context, listen: false).user;
      if (isRemember) {
        user.id = user.username = user.avatar = user.token = '';
      } else {
        user = User.empty();
      }
      Provider.of<UserProvider>(context, listen: false).user = user;
    });
    Application.router.navigateTo(context, Routes.login);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark =
        Provider.of<ThemeProvider>(context, listen: false).isDark;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kIndexPageAppbarHeight),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: theme
                  .extension<ExtensionColors>()!
                  .backgroundGrey
                  .withOpacity(0.5),
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            const CustomDragToMoveArea(),
            Positioned(
              left: 20.0,
              top: 15.0,
              child: WindowIconButton(
                iconWidget: SvgPicture.asset(
                    width: 128.0,
                    height: 36.0,
                    isDark
                        ? '${Constant.imagePath}logo-dark.svg'
                        : '${Constant.imagePath}logo-light.svg'),
                onPressed: () => widget.sidebarController.selectIndex(0),
              ),
            ),
            Positioned(
              top: 14.0,
              right: 174.0,
              child: UserMenuButton(
                avatar:
                    Provider.of<UserProvider>(context, listen: false).avatar,
                username:
                    Provider.of<UserProvider>(context, listen: false).username,
                userMenuItems: [
                  UserMenuItem(
                    label: 'User Settings',
                    iconPath: '${Constant.imagePath}user-settings.svg',
                    onTap: () => widget.sidebarController.selectIndex(0),
                  ),
                  UserMenuItem(
                    label: 'Logout',
                    iconPath: '${Constant.imagePath}logout.svg',
                    onTap: _logout,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 18.0,
              right: 24.0,
              child: Row(
                children: <Widget>[
                  WindowIconButton.setting(
                    backgroundColors: theme
                        .extension<ExtensionColors>()!
                        .buttonBackgroundColors,
                    iconColors:
                        theme.extension<ExtensionColors>()!.buttonIconColors,
                    onPressed: () {},
                  ),
                  WindowIconButton.notification(
                    backgroundColors: theme
                        .extension<ExtensionColors>()!
                        .buttonBackgroundColors,
                    iconColors:
                        theme.extension<ExtensionColors>()!.buttonIconColors,
                    onPressed: () {},
                  ),
                  Container(
                    width: 1.0,
                    height: 18.0,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    color: theme
                        .extension<ExtensionColors>()!
                        .textGrey
                        .withOpacity(0.5),
                  ),
                  WindowIconButton.minimize(
                    backgroundColors: theme
                        .extension<ExtensionColors>()!
                        .buttonBackgroundColors,
                    iconColors:
                        theme.extension<ExtensionColors>()!.buttonIconColors,
                    onPressed: () async {
                      bool isMinimized = await windowManager.isMinimized();
                      if (isMinimized) {
                        windowManager.restore();
                      } else {
                        windowManager.minimize();
                      }
                    },
                  ),
                  FutureBuilder<bool>(
                    future: windowManager.isMaximized(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == true) {
                        return WindowIconButton.unmaximize(
                          backgroundColors: theme
                              .extension<ExtensionColors>()!
                              .buttonBackgroundColors,
                          iconColors: theme
                              .extension<ExtensionColors>()!
                              .buttonIconColors,
                          onPressed: () => windowManager.unmaximize(),
                        );
                      }
                      return WindowIconButton.maximize(
                        backgroundColors: theme
                            .extension<ExtensionColors>()!
                            .buttonBackgroundColors,
                        iconColors: theme
                            .extension<ExtensionColors>()!
                            .buttonIconColors,
                        onPressed: () => windowManager.maximize(),
                      );
                    },
                  ),
                  WindowIconButton.close(
                    backgroundColors: theme
                        .extension<ExtensionColors>()!
                        .closeButtonBackgroundColors,
                    iconColors: theme
                        .extension<ExtensionColors>()!
                        .closeButtonIconColors,
                    onPressed: () => windowManager.close(),
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
