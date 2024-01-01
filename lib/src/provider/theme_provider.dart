import 'package:flutter/material.dart';

import 'package:toolbox/src/utils/theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    getPreferences();
  }

  bool _isDark = false;
  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    ThemePreferences.setTheme(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _isDark = await ThemePreferences.getTheme();
    notifyListeners();
  }

  ThemeMode themeMode() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
