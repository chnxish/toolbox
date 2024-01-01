import 'package:toolbox/src/constant/constant.dart';

class ServiceUrl {
  static const String login = '${Constant.backendUrl}api/accounts/token/';
  static const String refresh =
      '${Constant.backendUrl}api/accounts/token/refresh/';
  static const String users = '${Constant.backendUrl}api/accounts/users/';
  static const String forgotPassword = Constant.frontendUrl;
  static const String signUp = Constant.frontendUrl;
}
