import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  String get selectedName => _mode == ThemeMode.light ? 'Terang' : 'Gelap';

  void setTheme(String name) {
    if (name == 'Terang') {
      _mode = ThemeMode.light;
    } else if (name == 'Gelap') {
      _mode = ThemeMode.dark;
    }
    notifyListeners();
  }
}