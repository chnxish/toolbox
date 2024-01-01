import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/provider/theme_provider.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/widgets/window_appbar/index_page_appbar.dart';
import 'package:toolbox/src/widgets/popup/survey_feedback.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_controller.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_item.dart';
import 'package:toolbox/src/widgets/sidebar/sidebar_screens.dart';
import 'package:toolbox/src/widgets/sidebar/siderbar.dart';

const List<SidebarItem> sidebarItems = [
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

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with WindowListener {
  final SidebarController _controller = SidebarController(selectedIndex: 0);

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<ThemeProvider>(context, listen: false).isDark =
                !Provider.of<ThemeProvider>(context, listen: false).isDark,
      ),
      appBar: const IndexPageAppbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MultiSplitViewTheme(
              data: MultiSplitViewThemeData(
                dividerThickness: 4.0,
                dividerPainter:
                    DividerPainters.background(color: Colors.transparent),
              ),
              child: MultiSplitView(
                controller: MultiSplitViewController(areas: [
                  Area(size: 174.0, minimalSize: 174.0),
                  Area(minimalWeight: 0.8),
                ]),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                        width: 1,
                        color: Theme.of(context)
                            .extension<ExtensionColors>()!
                            .backgroundGrey
                            .withOpacity(0.5),
                      )),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Sidebar(
                          controller: _controller,
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
                    controller: _controller,
                    items: List.generate(
                      sidebarItems.length,
                      (index) {
                        return Center(
                          child: Text(sidebarItems[index].label),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
