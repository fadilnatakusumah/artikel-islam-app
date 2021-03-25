import 'dart:convert';

import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/style.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class ArticleDetailPage extends StatefulWidget {
  final Article article;
  final String endpoint;
  final ArticleService articleService;

  const ArticleDetailPage({
    Key? key,
    required this.article,
    this.endpoint = "",
    required this.articleService,
  }) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Article? _articleDetail;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getArticleDetail();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getArticleDetail();
    super.didChangeDependencies();
  }

  void getArticleDetail() {
    print("getArticleDetail");
    bool isSaved = widget.articleService.isAlreadySaved(widget.article);
    if (isSaved) {
      Article article = widget.articleService.loadDetailArticle(widget.article);
      return setState(() {
        _articleDetail = article;
        _isLoading = false;
      });
    }

    http.get("${widget.endpoint}/detail/${widget.article.id}").then((value) {
      final response = json.decode(value.body);
      if (response["success"] == true) {
        // print('response["data"]["data"] ${response["data"]["data"]}');
        this.setState(() {
          _articleDetail = Article.fromJson(response["data"]);
          _isLoading = false;
        });
      }
    });
  }

  void saveArticle(BuildContext context) async {
    try {
      await widget.articleService.saveToLocal(_articleDetail!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Artikel tersimpan"),
        duration: Duration(seconds: 2),
      ));
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  void unsaveArticle(BuildContext context) async {
    print("unsaveArticle");
    await widget.articleService.unsaveFromLocal(widget.article);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Artikel di hapus"),
        duration: Duration(seconds: 2),
      ),
    );
    setState(() {});
  }

  Future<bool> get isArticleSaved async {
    // final tempArticle = await getLocalArticleData();
    // print("tempArticle $tempArticle");
    // return tempArticle != null ? true : false;
    return widget.articleService.isAlreadySaved(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    print("isArticleSaved $isArticleSaved");
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Stack(
                        // fit: StackFit.expand,
                        children: [
                          // Image.network(_articleDetail.thumbnail),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 280,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _articleDetail?.thumbnail ??
                                      "https://watertownbusinesscoalition.com/assets/images/no_image_available.jpeg",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                  ),
                                  FutureBuilder(
                                    future: isArticleSaved,
                                    initialData: false,
                                    builder: (
                                      BuildContext context,
                                      AsyncSnapshot snapshot,
                                    ) {
                                      return IconButton(
                                        icon: Icon(
                                          snapshot.data == true
                                              ? Icons.bookmark
                                              : Icons.bookmark_outline_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () => snapshot.data == true
                                            ? unsaveArticle(context)
                                            : saveArticle(context),
                                      );
                                      // ;
                                    },
                                  ),
                                ],
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withAlpha(50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _articleDetail!.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _articleDetail!.author,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            _articleDetail!.date,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        style: {"*": Style(fontSize: FontSize(15))},
                        data: _articleDetail!.content_html,
                        //Optional parameters:
                        // backgroundColor: Colors.white70,
                        onLinkTap: (url) {
                          // open url in a webview
                        },
                        // style: {
                        //   "div": Style(
                        //     block: Display.BLOCK(
                        //       margin: EdgeInsets.all(16),
                        //       border: Border.all(width: 6),
                        //       backgroundColor: Colors.grey,
                        //     ),
                        //     textStyle: TextStyle(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        // },
                        onImageTap: (src) {
                          // Display the image in large form.
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
