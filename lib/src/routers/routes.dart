import 'package:fluro/fluro.dart';

import 'package:toolbox/src/routers/route_handles.dart';

class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static void configureRoutes(FluroRouter router) {
    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(signup, handler: signupHandler);
  }
}
