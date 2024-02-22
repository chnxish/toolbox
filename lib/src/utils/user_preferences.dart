import 'package:toolbox/src/utils/sp_util.dart';

class UserPreferences {
  static const String _spId = 'id';
  static const String _spUsername = 'username';
  static const String _spEmail = 'email';
  static const String _spPassword = 'password';
  static const String _spAvatar = 'avatar';
  static const String _spToken = 'token';
  static const String _spRemember = 'remember';

  static Future<String> getId() async {
    return SpUtil.getString(_spId);
  }

  static Future<void> setId(String value) async {
    SpUtil.setString(_spId, value);
  }

  static Future<String> getUsername() async {
    return SpUtil.getString(_spUsername);
  }

  static Future<void> setUsername(String value) async {
    SpUtil.setString(_spUsername, value);
  }

  static Future<String> getEmail() async {
    return SpUtil.getString(_spEmail);
  }

  static Future<void> setEmail(String value) async {
    SpUtil.setString(_spEmail, value);
  }

  static Future<String> getPassword() async {
    return SpUtil.getString(_spPassword);
  }

  static Future<void> setPassword(String value) async {
    SpUtil.setString(_spPassword, value);
  }

  static Future<String> getAvatar() async {
    return SpUtil.getString(_spAvatar);
  }

  static Future<void> setAvatar(String value) async {
    SpUtil.setString(_spAvatar, value);
  }

  static Future<String> getToken() async {
    return SpUtil.getString(_spToken);
  }

  static Future<void> setToken(String value) async {
    SpUtil.setString(_spToken, value);
  }

  static Future<bool> getRemember() async {
    return SpUtil.getBool(_spRemember);
  }

  static Future<void> setRemember(bool value) async {
    SpUtil.setBool(_spRemember, value);
  }

  static Future<void> clear() async {
    SpUtil.remove(_spId);
    SpUtil.remove(_spUsername);
    SpUtil.remove(_spEmail);
    SpUtil.remove(_spPassword);
    SpUtil.remove(_spAvatar);
    SpUtil.remove(_spToken);
    SpUtil.remove(_spRemember);
  }
}
