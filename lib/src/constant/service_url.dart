import 'package:toolbox/src/constant/constant.dart';

class ServiceUrl {
  static const String signup = '${Constant.backendUrl}api/accounts/signup/';
  static const String login = '${Constant.backendUrl}api/accounts/login/';
  static const String logout = '${Constant.backendUrl}api/accounts/logout/';
  static const String forgotPassword = '${Constant.backendUrl}password-reset/';
  static const String profile = '${Constant.backendUrl}profile/';
}
