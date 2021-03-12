import 'dart:convert';

import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:artikel_islam/widgets/article_card.dart';
import 'package:artikel_islam/widgets/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ArticleSection extends StatefulWidget {
  final String endpointUrl;
  final String title;
  final VoidCallback onTap;
  final ArticleService articleService;

  const ArticleSection({
    Key key,
    @required this.endpointUrl,
    this.title = "Article Title",
    this.onTap,
    this.articleService,
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
    print("parentLoading $parentLoading");
    if (parentLoading == true) {
      getListArticles();
    } else {
      setState(() {
        _loading = false;
      });
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
        _loading = false;
        _listArticles = results;
      });
    }).catchError((onError) {
      setState(() => _loading = false);
      print("Error $onError");
    });
  }

  List<Widget> get _renderListArticles {
    return _listArticles.map((Article article) {
      // return Text(article.title);
      return ArticleCard(
        article: article,
        endpoint: widget.endpointUrl,
        onTap: widget.onTap,
      );
    }).toList();
  }

  Widget buildSectionSkeleton() {
    return Container(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonContainer.square(
                width: 150.0,
                height: 16.0,
              ),
              SizedBox(height: 5),
              SkeletonContainer.rounded(
                width: 250.0,
                height: 150.0,
              ),
              SizedBox(height: 5),
              SkeletonContainer.square(
                width: 200.0,
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _loading
              ? buildSectionSkeleton()
              : Container(
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _renderListArticles,
                        ),
                      )
                    ],
                  ),
                ),
        ),
        // Container(
        //   height: 200,
        //   child: _loading
        //       // ? Text("LOADING")
        //       ? buildSectionSkeleton()
        //       : null
        // Column(
        //         mainAxisSize: MainAxisSize.max,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             widget.title,
        //             style: TextStyle(
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           SizedBox(height: 5),
        //           Expanded(
        //             child: ConstrainedBox(
        //               constraints: BoxConstraints(
        //                 minHeight: 150
        //               ),
        //               child: ListView(
        //                 scrollDirection: Axis.horizontal,
        //                 children: _renderListArticles,
        //                 shrinkWrap: true,
        //               ),
        //             ),
        //           )
        //           // Expanded(
        //           //   child: ListView(
        //           //     scrollDirection: Axis.horizontal,
        //           //     children: _renderListArticles,
        //           //     shrinkWrap: false,
        //           //   ),
        //           // ),
        //         ],
        //       ),
        // )
      ],
    );
  }
}
