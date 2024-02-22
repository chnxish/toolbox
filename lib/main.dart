import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/provider/user_provider.dart';
import 'package:toolbox/src/provider/theme_provider.dart';
import 'package:toolbox/src/routers/application.dart';
import 'package:toolbox/src/routers/routes.dart';
import 'package:toolbox/src/services/dio_service.dart';
import 'package:toolbox/src/theme/theme.dart';
import 'package:toolbox/src/utils/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.init();
  await DioService.init();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: 'ToolBox',
    size: Constant.windowSize,
    minimumSize: Constant.windowSize,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();

    return MaterialApp(
      initialRoute: Routes.login,
      onGenerateRoute: Application.router.generator,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context, listen: true).themeMode(),
      builder: (context, child) {
        return virtualWindowFrameBuilder(context, child);
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
