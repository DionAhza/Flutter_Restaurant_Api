import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  static const themeKey = "theme_mode";

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {

    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool(themeKey);

    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> toggleTheme(bool isDark) async {

    final prefs = await SharedPreferences.getInstance();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    await prefs.setBool(themeKey, isDark);

    notifyListeners();
  }
}