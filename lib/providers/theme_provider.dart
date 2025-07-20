import 'package:flutter/material.dart';
import '../utils/shared_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = SharedPrefs.getIsDark() ?? false;
  bool get isDarkMode => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    SharedPrefs.setIsDark(_isDark);
    notifyListeners();
  }
}
