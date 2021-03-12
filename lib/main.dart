import 'package:artikel_islam/pages/bookmark_page.dart';
import 'file:///D:/MyProjects/mobile/flutter/Serious%20Projects/artikel_islam/lib/pages/home_page.dart';
import 'package:artikel_islam/pages/root_page.dart';
import 'package:artikel_islam/utlis/theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => HomePage(),
      //   "/bookmark": (context) => BookmarkPage(),
      // },
      home: RootPage(),
    );
  }
}
