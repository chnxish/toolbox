import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  factory SpUtil() => _instance;

  static final SpUtil _instance = SpUtil._internal();
  static late SharedPreferences _prefs;

  SpUtil._internal() {
    init();
  }

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Map<String, dynamic>? getObject(String key) {
    String? data = _prefs.getString(key);
    return json.decode(data ?? '');
  }

  static Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return _prefs.setString(key, json.encode(value));
  }

  static String getString(String key, {String defValue = ''}) {
    return _prefs.getString(key) ?? defValue;
  }

  static Future<bool> setString(String key, String? value) {
    return _prefs.setString(key, value ?? '');
  }

  static bool getBool(String key, {bool defValue = false}) {
    return _prefs.getBool(key) ?? defValue;
  }

  static Future<bool> setBool(String key, bool? value) {
    return _prefs.setBool(key, value ?? false);
  }

  static int getInt(String key, {int defValue = 0}) {
    return _prefs.getInt(key) ?? defValue;
  }

  static Future<bool> setInt(String key, int? value) {
    return _prefs.setInt(key, value ?? 0);
  }

  static double getDouble(String key, double defValue) {
    return _prefs.getDouble(key) ?? defValue;
  }

  static Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    return _prefs.getStringList(key) ?? defValue;
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  static bool haveKey(String key) {
    return _prefs.getKeys().contains(key);
  }

  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  static Future<bool> clear() {
    return _prefs.clear();
  }
}
