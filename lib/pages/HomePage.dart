import 'dart:convert';

import 'package:artikel_islam/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Article> konsultasiSyariah = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKonsultasiSyariahArticle();
  }

  Future<void> getKonsultasiSyariahArticle() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http
          .get("https://artikel-islam.netlify.app/.netlify/functions/api/ks");
      // var url = 'https://example.com/whatsit/create';
      // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
      print('Response status: ${response.statusCode}');
      final test = json.decode(response.body);
      final results = test["data"]["data"] as List;
      final List<Article> listArticles = [];
      results.map((e) => listArticles.add(Article.fromJson(e))).toList();
      setState(() {
        konsultasiSyariah = listArticles;
      });
    } catch (err) {
      konsultasiSyariah = [];
      print("Error $err");
    }
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> get renderKonsultasiSyariah {
    return konsultasiSyariah
        .map((Article data) => Container(
              width: 220,
              margin: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data.thumbnail ??
                          "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg",
                      scale: .5,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data.date,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.grey,
        ),
        backgroundColor: Colors.transparent,
        title: Text("Artikel"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined),
            onPressed: () {},
            color: Colors.grey,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              getKonsultasiSyariahArticle();
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  margin: EdgeInsets.all(12),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Konsultasi Syariah",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Muslimorid",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Rumaysho",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Firanda.com",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      // Container(width: 100, child: Text("Muslimorid")),
                      // Container(width: 100, child: Text("Rumaysho"))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: Text(
                        "Konsultasi Syariah",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.all(10),
                      child: isLoading
                          ? ListSkeleton(
                              style: SkeletonStyle(
                                theme: SkeletonTheme.Light,
                                isShowAvatar: false,
                                barCount: 3,
                                colors: [
                                  Colors.grey,
                                  Colors.black12,
                                  Colors.black26,
                                ],
                                isAnimation: true,
                              ),
                            )
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: renderKonsultasiSyariah,
                              // [
                              //   Card(
                              //     child: Column(
                              //       children: [
                              //         Image.network(
                              //           "https://i1.sndcdn.com/artworks-000249209479-6tn1y6-t500x500.jpg",
                              //           height: 150,
                              //         )
                              //       ],
                              //     ),
                              //   )
                              // ],
                            ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
