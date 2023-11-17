import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  static late SharedPreferences _prefs;

  SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    _instance ??= SharedPreferencesHelper._internal();
    return _instance!;
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
