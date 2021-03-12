import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/pages/search_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/material.dart';

class SelectCategoryPage extends StatefulWidget {
  final ArticleService articleService;
  final bool isConnected;

  const SelectCategoryPage({Key key, this.articleService, this.isConnected})
      : super(key: key);

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  bool _isLoading = false;
  bool _isConnected = true;

  @override
  void initState() {
    print("INIT STATE");
    checkConnection();
  }

  void checkConnection() async {
    bool isConnected = await checkIsConnected();
    print("isConnected $isConnected");
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
        onTap: () {
          showSearch(
              context: context,
              delegate: DataSearch(
                articleService: widget.articleService,
                categoryArticle: category,
              ));
        },
      );
    }).toList();
  }

  Widget _renderPage(BuildContext context) {
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
          title: Text("Pilih website"),
          centerTitle: true,
        ),
        // ignore: unrelated_type_equality_checks
        body: _renderPage(context));
  }
}
