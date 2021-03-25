import 'package:artikel_islam/pages/about_page.dart';
import 'package:artikel_islam/pages/categories.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  final ArticleService articleService;

  const DrawerPage({
    Key? key,
    required this.articleService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.asset(
                  "assets/artikel_islam.png",
                  width: 80,
                ),
              ),
            ),
          ),
//          ListTile(
//            leading: Icon(
//              Icons.settings,
//              size: 24,
//              color: Colors.black,
//            ),
//            title: Text(
//              "Settings",
//              style: _textStyle,
//            ),
//          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => CategoriesPage(
                  articleService: articleService,
                ),
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.web,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Website Islam",
                style: _textStyle,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => AboutPage()
            )),
            child: ListTile(
              leading: Icon(
                Icons.info,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Tentang aplikasi",
                style: _textStyle,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('v1.0.0'),
                Text(
                  'fadilnatakusumah',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<ArticleService>('articleService', articleService));
  }
}
