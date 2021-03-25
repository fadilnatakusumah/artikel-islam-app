import 'dart:convert';

import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/pages/search_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'article_detail_page.dart';

class ArticlesPage extends StatefulWidget {
  final ArticleService articleService;
  final CategoryArticle categoryArticle;

  const ArticlesPage({
    Key? key,
    required this.categoryArticle,
    required this.articleService,
  }) : super(key: key);

  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _isConnected = false;
  String _page = "1";
  String _totalPage = "1";
  List<Article> _articles = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widgetMounted();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    super.initState();
  }

  void widgetMounted() async {
    await checkConnection();
    getList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getList() async {
    setState(() {
      _isLoading = true;
    });
    widget.articleService
        .searchArticle(categoryArticle: widget.categoryArticle)
        .then((response) {
      var data = response["data"] as List<Article>;
      var newPage = response["pagination"]["page"];
      var newTotalPage = response["pagination"]["total_page"];
      setState(() {
        _articles = data;
        _page = newPage;
        _totalPage = newTotalPage;
        _isLoading = false;
      });
      if (_articles.length < 10) {
        loadMore();
      }
    });
  }

  void loadMore() async {
    if (int.parse(_page) >= int.parse(_totalPage)) return;
    print("loading more...");
    setState(() {
      _isLoadingMore = true;
    });

    widget.articleService.searchArticle(
      categoryArticle: widget.categoryArticle,
      params: {
        "page": (int.parse(_page) + 1).toString(),
      },
    ).then((response) {
      var data = response["data"] as List<Article>;
      var newPage = response["pagination"]["page"];
      var newTotalPage = response["pagination"]["total_page"];
      print("data $data");
      print("articles $_articles");
      setState(() {
        _articles = List.from(_articles)..addAll(data);
        _page = newPage;
        _totalPage = newTotalPage;
        _isLoadingMore = false;
      });
    });
  }

  void _goToDetailArticle(BuildContext context, Article article) async {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ArticleDetailPage(
          article: article,
          endpoint: widget.categoryArticle.endpointUrl,
          articleService: widget.articleService,
        ),
      ),
    );
  }

  Future<void> checkConnection() async {
    bool isConnected = await checkIsConnected();
    setState(() {
      _isConnected = isConnected;
    });
  }

  List<Widget> _renderArticles(BuildContext context) {
    return _articles.map((article) {
      return ListTile(
        onTap: () => _goToDetailArticle(context, article),
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(
          article.thumbnail,
          width: 100,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.author,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            // SizedBox(
            //   width: 10,
            //   child: Text(","),
            // ),
            Text(
              article.date,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );
    }).toList();
  }

  Widget _renderPage(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!_isLoading && _isConnected) {
      return ListView(
        controller: _scrollController,
        children: [
          ..._renderArticles(context),
          _isLoadingMore
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      );
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
          title: Text(widget.categoryArticle.name),
          centerTitle: true,
        ),
        // ignore: unrelated_type_equality_checks
        body: _renderPage(context));
  }
}
