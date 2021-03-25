import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xFFCAECFF);
  static Color primaryDark = Color(0xFF0388bb);
  static Color secondaryLight = Color(0xFFa2dcf9);

  ThemeData buildTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          color: primaryDark,
          // textTheme: TextTheme(
          //   headline4: TextStyle(color: Colors.white),
          // ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      canvasColor: primaryLight,
      primaryColor: primaryLight,
      accentColor: primaryDark,
    );
  }
}
