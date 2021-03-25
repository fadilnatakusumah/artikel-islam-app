import 'file:///D:/MyProjects/mobile/flutter/Serious%20Projects/artikel_islam/lib/pages/home_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ChangeNotifierProvider(
      create: (context) => ArticleService(),
      child: HomePage(),
    );
  }
}
