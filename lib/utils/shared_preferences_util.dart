import 'package:shared_preferences/shared_preferences.dart';

/// Local storage için SharedPreferences wrapper
class SharedPreferencesUtil {
  static SharedPreferencesUtil? _instance;
  SharedPreferences? _prefs;

  SharedPreferencesUtil._();

  static Future<SharedPreferencesUtil> getInstance() async {
    _instance ??= SharedPreferencesUtil._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  static SharedPreferencesUtil get instance {
    _instance ??= SharedPreferencesUtil._();
    return _instance!;
  }

  // Token Management
  Future<bool> setToken(String token) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setString('token', token);
  }

  String? getToken() {
    return _prefs?.getString('token');
  }

  Future<bool> removeToken() async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.remove('token');
  }

  // User ID Management
  Future<bool> setUserId(int userId) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setInt('userId', userId);
  }

  int? getUserId() {
    return _prefs?.getInt('userId');
  }

  // Generic Methods
  Future<bool> setString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<bool> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.remove(key);
  }

  Future<bool> removeAll() async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.clear();
  }
}

