import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String appLanguage = "en";

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    notifyListeners();
  }

  bool isDarkMode() => appTheme == ThemeMode.dark;
}