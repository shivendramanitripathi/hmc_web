import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = AppTheme.theme1;

  ThemeData get currentTheme => _currentTheme;

  void setTheme(String themeName) {
    if (AppTheme.themes.containsKey(themeName)) {
      _currentTheme = AppTheme.themes[themeName]!;
      notifyListeners();
    } else {
      throw Exception('Theme $themeName not found');
    }
  }
}
