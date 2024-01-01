import 'package:toolbox/src/utils/sp_util.dart';

class ThemePreferences {
  static const String _spTheme = 'theme';

  static Future<bool> getTheme() async {
    return SpUtil.getBool(_spTheme);
  }

  static Future<void> setTheme(bool value) async {
    SpUtil.setBool(_spTheme, value);
  }
}
