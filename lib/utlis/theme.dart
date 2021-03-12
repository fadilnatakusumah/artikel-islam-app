import 'package:flutter/material.dart';

class MyTheme {
  Color primaryLight = Color(0xFFCAECFF);
  Color primaryDark = Color(0xFF0388bb);

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
