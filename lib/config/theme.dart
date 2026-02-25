import 'package:flutter/material.dart';

import 'custom_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Microsoft YaHei',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF2E70ED),
    textTheme: TextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
      fillColor: Color(0xFFF3F3F3),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.white),
      // menuStyle: MenuStyle(
      //   backgroundColor: WidgetStateProperty.all(Colors.white),
      // ),
    ),
    dividerColor: Color(0xFFE0E0E0),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return SystemMouseCursors.basic;
          }
          return SystemMouseCursors.click;
        }),
      ),
    ),
    iconTheme: IconThemeData(color: Color(0xFF727272)),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      barrierColor: Colors.white.withValues(alpha: .6),
    ),
    extensions: [
      SlidingSegmentedTheme(
        backgroundColor: Color(0xFFF3F3F3),
        foregroundColor: Colors.white,
      ),
      ToastTheme(backgroundColor: Colors.white),
      SideTheme(
        largeStyle: TextStyle(
          color: Color(0xFF666666),
          fontSize: 16,
          fontFamily: 'Microsoft YaHei',
        ),
        mediumStyle: TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
          fontFamily: 'Microsoft YaHei',
        ),
      ),
    ],
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Microsoft YaHei',
    scaffoldBackgroundColor: Color(0xFF222222),
    primaryColor: Color(0xFF2E70ED),
    textTheme: TextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
      fillColor: Color(0xFF333333),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xFF111111)),
      // menuStyle: MenuStyle(
      //   backgroundColor: WidgetStateProperty.all(Color(0xFF333333)),
      // ),
    ),
    dividerColor: Color(0xFF404040),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return SystemMouseCursors.basic;
          }
          return SystemMouseCursors.click;
        }),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    dialogTheme: DialogThemeData(
      backgroundColor: Color(0xFF111111),
      barrierColor: Colors.black.withValues(alpha: .6),
    ),
    extensions: [
      SlidingSegmentedTheme(
        backgroundColor: Color(0xFF333333),
        foregroundColor: Color(0xFF222222),
      ),
      ToastTheme(backgroundColor: Color(0xFF222222)),
      SideTheme(
        largeStyle: TextStyle(
          color: Color(0xFFDDDDDD),
          fontSize: 16,
          fontFamily: 'Microsoft YaHei',
        ),
        mediumStyle: TextStyle(
          color: Color(0xFFDDDDDD),
          fontSize: 14,
          fontFamily: 'Microsoft YaHei',
        ),
      ),
    ],
  );
}
