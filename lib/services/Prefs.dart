import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Future setLoginInfo(userId) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('userId', userId);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await _prefs;
    return {
      "userId": await prefs.getString("userId"),
      "isLoggedIn": await prefs.getBool("isLoggedIn") == null
          ? false
          : prefs.getBool("isLoggedIn")
    };
  }

  static Future toggleIsLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("isLoggedIn", !(await prefs.getBool("isLoggedIn") ?? true));
  }

  static Future setUserId(userId) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("userId", userId);
  }
}        