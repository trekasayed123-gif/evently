
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0XFFFFFFFF),
      onPrimary: Color(0XFF0E3A99),
      secondary: Color(0XFF0E3A99),
      onSecondary: Color(0XFF202020),
      error: Color(0XFF0E3A99),
      onError: Color(0XFFFFFFFF),
      surface: Color(0XFFFFFFFF),
      onSurface: Color(0XFF686868),
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff000F30),
      onPrimary: Color(0XFFFFFFFF),
      secondary: Color(0XFF457AED),
      onSecondary: Color(0XFFFFFFFF),
      error: Color(0XFF0E3A99),
      onError: Color(0XFFFFFFFF),
      surface: Color(0XFF000F30),
      onSurface: Color(0XFFFFFFFF),
    ),
  );
}