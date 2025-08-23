import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();
  factory StorageUtil() => _instance;
  static late SharedPreferences _prefs;

  StorageUtil._();

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static bool? getNullBool(String key) => _prefs.getBool(key);

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static int? getInt(String key) => _prefs.getInt(key);
  //
  // static Future<bool> setDouble(String key, double value) =>
  //     _prefs.setDouble(key, value);
  //
  // static double? getDouble(String key) => _prefs.getDouble(key);
  //
  // // 存储 List<String>
  // static Future<bool> setStringList(String key, List<String> value) =>
  //     _prefs.setStringList(key, value);
  //
  // static List<String> getStringList(String key) {
  //   List<String>? value = _prefs.getStringList(key);
  //   return value ?? [];
  // }
  //
  static Future<bool> remove(String key) => _prefs.remove(key);
  static Future<bool> clear() => _prefs.clear();
}
