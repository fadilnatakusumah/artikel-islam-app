import 'dart:convert';

import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ArticleSection extends StatefulWidget {
  final String endpointUrl;
  final String title;

  const ArticleSection({
    Key key,
    @required this.endpointUrl,
    this.title = "Article Title",
  }) : super(key: key);

  @override
  _ArticleSectionState createState() => _ArticleSectionState();
}

class _ArticleSectionState extends State<ArticleSection> {
  bool _loading = true;
  List<Article> _listArticles = [];

  @override
  void initState() {
    getListArticles();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final parentLoading = Provider.of<bool>(context, listen: true);
    if (parentLoading == true) {
      getListArticles();
    }
    super.didChangeDependencies();
  }

  void getListArticles() async {
    setState(() => _loading = true);
    http.get(widget.endpointUrl).then((value) {
      final response = json.decode(value.body);
      final List<Article> results = [];
      if (response["success"] == true) {
        final list = response["data"]["data"] as List;
        list.map((data) {
          results.add(new Article.fromJson(data));
        }).toList();
      }
      setState(() {
        _listArticles = results;
        _loading = false;
      });
    });
  }

  List<Widget> get _renderListArticles {
    return _listArticles.map((Article article) {
      return ArticleCard(article: article);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280,
          child: _loading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 250.0,
                          height: 150.0,
                          margin: EdgeInsets.only(right: 15.0),
                          color: Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 200.0,
                          height: 12.0,
                          margin: EdgeInsets.only(right: 15.0),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _renderListArticles,
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
