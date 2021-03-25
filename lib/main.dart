// @dart=2.9
import 'package:artikel_islam/pages/root_page.dart';
import 'package:artikel_islam/pages/search_page.dart';
import 'package:artikel_islam/utlis/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artikel Islam',
      debugShowCheckedModeBanner: false,
      theme: MyTheme().buildTheme(),
      localizationsDelegates: [
        CustomLocalizationDelegate(),
      ],
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => HomePage(),
      //   "/bookmark": (context) => BookmarkPage(),
      // },
      home: RootPage(),
    );
  }
}
