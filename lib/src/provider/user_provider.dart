import 'package:flutter/material.dart';

import 'package:toolbox/src/models/user.dart';
import 'package:toolbox/src/utils/user_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    getPreferences();
  }

  User _user = User.empty();
  bool _isRemember = true;

  String get id => _user.id;
  String get username => _user.username;
  String get email => _user.email;
  String get password => _user.password;
  String get avatar => _user.avatar;
  String get token => _user.token;
  User get user => _user;
  bool get isRemember => _isRemember;

  set id(String value) {
    _user.id = value;
    UserPreferences.setId(value);
    notifyListeners();
  }

  set username(String value) {
    _user.username = value;
    UserPreferences.setUsername(value);
    notifyListeners();
  }

  set email(String value) {
    _user.email = value;
    UserPreferences.setEmail(value);
    notifyListeners();
  }

  set password(String value) {
    _user.password = _isRemember ? value : '';
    UserPreferences.setPassword(_user.password);
    notifyListeners();
  }

  set avatar(String value) {
    _user.avatar = value;
    UserPreferences.setAvatar(value);
    notifyListeners();
  }

  set token(String value) {
    _user.token = value;
    UserPreferences.setToken(value);
    notifyListeners();
  }

  set user(User user) {
    _user = user;
    UserPreferences.setId(user.id);
    UserPreferences.setUsername(user.username);
    UserPreferences.setEmail(user.email);
    UserPreferences.setPassword(user.password);
    UserPreferences.setAvatar(user.avatar);
    UserPreferences.setToken(user.token);
    notifyListeners();
  }

  set isRemember(bool value) {
    _isRemember = value;
    UserPreferences.setRemember(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    final id = await UserPreferences.getId();
    final username = await UserPreferences.getUsername();
    final email = await UserPreferences.getEmail();
    final password = await UserPreferences.getPassword();
    final avatar = await UserPreferences.getAvatar();
    final token = await UserPreferences.getToken();

    _user = User(
        id: id,
        username: username,
        email: email,
        password: password,
        avatar: avatar,
        token: token);

    _isRemember = await UserPreferences.getRemember();
    notifyListeners();
  }
}
