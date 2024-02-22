import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:toolbox/src/pages/index_page.dart';
import 'package:toolbox/src/pages/login_page.dart';
import 'package:toolbox/src/pages/signup_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const IndexPage();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});

var signupHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SignupPage();
});
