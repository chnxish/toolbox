import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/pages/chat_page.dart';
import 'package:toolbox/src/pages/home_page.dart';
import 'package:toolbox/src/pages/note_page.dart';
import 'package:toolbox/src/pages/todo_page.dart';
import 'package:toolbox/src/provider/theme_provider.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/window_appbar/index_page_appbar.dart';
import 'package:toolbox/src/widgets/popup/survey_feedback.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_item.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_screens.dart';
import 'package:toolbox/src/widgets/sidebar/siderbar.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with WindowListener {
  final SidebarController _sidebarController =
      SidebarController(selectedIndex: 0);
  final MultiSplitViewController _multiSplitViewController =
      MultiSplitViewController(areas: [
    Area(size: 174.0, minimalSize: 174.0),
    Area(minimalWeight: 0.8),
  ]);

  final List<SidebarItem> sidebarItems = const [
    SidebarItem(
      label: 'Home',
      outlineIconPath: '${Constant.imagePath}outline-home.svg',
      boldIconPath: '${Constant.imagePath}bold-home.svg',
    ),
    SidebarItem(
      label: 'Chat',
      outlineIconPath: '${Constant.imagePath}outline-chat.svg',
      boldIconPath: '${Constant.imagePath}bold-chat.svg',
    ),
    SidebarItem(
      label: 'Notes',
      outlineIconPath: '${Constant.imagePath}outline-note.svg',
      boldIconPath: '${Constant.imagePath}bold-note.svg',
    ),
    SidebarItem(
      label: 'To Do',
      outlineIconPath: '${Constant.imagePath}outline-todo.svg',
      boldIconPath: '${Constant.imagePath}bold-todo.svg',
    ),
  ];

  final List<Widget> sidebarBodies = const [
    HomePage(),
    ChatPage(),
    NotePage(),
    TodoPage(),
  ];

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setResizable(true);
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    _multiSplitViewController.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<ThemeProvider>(context, listen: false).isDark =
                !Provider.of<ThemeProvider>(context, listen: false).isDark,
      ),
      appBar: IndexPageAppbar(sidebarController: _sidebarController),
      body: Stack(
        children: <Widget>[
          MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerThickness: 4.0,
              dividerPainter: DividerPainters.background(
                  color: theme
                      .extension<ExtensionColors>()!
                      .backgroundGrey
                      .withOpacity(0.05)),
            ),
            child: MultiSplitView(
              controller: _multiSplitViewController,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                      width: 1,
                      color: theme
                          .extension<ExtensionColors>()!
                          .backgroundGrey
                          .withOpacity(0.5),
                    )),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Sidebar(
                        sidebarController: _sidebarController,
                        items: List.generate(
                          sidebarItems.length,
                          (index) {
                            return sidebarItems[index];
                          },
                        ),
                      ),
                      const Positioned(bottom: 0.0, child: SurveyFeedback()),
                    ],
                  ),
                ),
                SidebarScreens(
                  controller: _sidebarController,
                  items: sidebarBodies,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
