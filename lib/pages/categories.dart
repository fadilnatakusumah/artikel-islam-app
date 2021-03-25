import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/pages/articles.dart';
import 'package:artikel_islam/pages/search_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  final ArticleService articleService;

  const CategoriesPage({
    Key? key,
    required this.articleService,
  }) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _isLoading = true;
  bool _isConnected = false;

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  void checkConnection() async {
    setState(() {
      _isLoading = true;
    });
    bool isConnected = await checkIsConnected();
    setState(() {
      _isConnected = isConnected;
      _isLoading = false;
    });
  }

  List<Widget> _renderCategories(BuildContext context) {
    return LIST_CATEGORIES.map((CategoryArticle category) {
      return ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(category.logo),
        title: Text(category.name),
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ArticlesPage(
                  categoryArticle: category,
                  articleService: widget.articleService,
                ))),
      );
    }).toList();
  }

  Widget _renderPage(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Text("Internet tidak tersambung"),
      );
    }
    if (!_isLoading && _isConnected) {
      return ListView(children: _renderCategories(context));
    }
    if (!_isLoading && !_isConnected) {
      return Center(
        child: Text("Internet tidak tersambung"),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Website Islam"),
          centerTitle: true,
        ),
        // ignore: unrelated_type_equality_checks
        body: _renderPage(context));
  }
}
