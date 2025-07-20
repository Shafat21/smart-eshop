import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  // Auth token
  static String? getToken() => _prefs.getString('token');
  static Future<bool> setToken(String token) => _prefs.setString('token', token);
  static Future<bool> clearToken() => _prefs.remove('token');

  // Username & real name
  static String? getUsername() => _prefs.getString('username');
  static Future<bool> setUsername(String v) => _prefs.setString('username', v);
  static Future<bool> clearUsername() => _prefs.remove('username');

  static String? getName() => _prefs.getString('name');
  static Future<bool> setName(String v) => _prefs.setString('name', v);
  static Future<bool> clearName() => _prefs.remove('name');

  // Email, Phone, Address
  static String? getEmail() => _prefs.getString('email');
  static Future<bool> setEmail(String v) => _prefs.setString('email', v);
  static Future<bool> clearEmail() => _prefs.remove('email');

  static String? getPhone() => _prefs.getString('phone');
  static Future<bool> setPhone(String v) => _prefs.setString('phone', v);
  static Future<bool> clearPhone() => _prefs.remove('phone');

  static String? getAddress() => _prefs.getString('address');
  static Future<bool> setAddress(String v) => _prefs.setString('address', v);
  static Future<bool> clearAddress() => _prefs.remove('address');

  // Theme
  static bool? getIsDark() => _prefs.getBool('isDark');
  static Future<bool> setIsDark(bool v) => _prefs.setBool('isDark', v);

  // Favourites
  static List<String>? getFavourites() => _prefs.getStringList('favourites');
  static Future<bool> setFavourites(List<String> list) =>
      _prefs.setStringList('favourites', list);
}
