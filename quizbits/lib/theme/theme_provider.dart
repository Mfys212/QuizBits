import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'selected_theme';

  String _selectedName = 'Terang';
  ThemeMode _themeMode = ThemeMode.light;

  String get selectedName => _selectedName;
  ThemeMode get themeMode => _themeMode;
  ThemeData get themeData => _themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);

    if (saved != null) {
      _selectedName = saved;
      _themeMode = saved == 'Gelap' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> setTheme(String name) async {
    _selectedName = name;
    _themeMode = name == 'Gelap' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, name);
  }
}