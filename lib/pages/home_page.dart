import 'dart:io';

import 'package:artikel_islam/constants/api_endpoint.dart';
import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/pages/article_detail_page.dart';
import 'package:artikel_islam/pages/bookmark_page.dart';
import 'package:artikel_islam/pages/drawer_page.dart';
import 'package:artikel_islam/pages/search_page.dart';
import 'package:artikel_islam/pages/select_category.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:artikel_islam/widgets/article_section.dart';
import 'package:artikel_islam/widgets/connection_fallback.dart';
import 'package:artikel_islam/widgets/popular_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  ArticleService _articleService;
  bool isConnected = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("didChangeDependencies");
    _initData();
    super.didChangeDependencies();
  }

  @override
  initState() {
    print("initState");
    _initData();
    super.initState();
  }

  void _initData() async {
    print("_initData");
    bool checkConnection = await checkIsConnected();
    print("checkConnection: $checkConnection");
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    _articleService = Provider.of<ArticleService>(context, listen: false);
    _articleService.init().then((_) => setState(() {
          isConnected = checkConnection;
          isLoading = false;
        }));
    // });
  }

  Future<void> getListData() async {
    print("getListData()");
    setState(() => isLoading = true);
    // bool checkConnection = await checkIsConnected();
    // print("checkConnection $checkConnection");
    // _articleService.loadSavedArticles();
    // setState(() {
    //   isConnected = checkConnection;
    // });
    // if (checkIsConnected() == false) {
    //   setState(() {
    //     isConnected = false;
    //     isLoading = false;
    //   });
    //
    //   return;
    // }

    // if (check == false) {
    //   print("TIDAK TERSAMBUNG");
    //   setState(() {
    // isConnected = false;
    // isLoading = false;
    //   });
    //   return;
    // }
    await Future.delayed(Duration(milliseconds: 2500));
    setState(() => isLoading = false);
  }

  // _showModalBottomSheet(BuildContext context) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     // backgroundColor: Colors.white,
  //     builder: (context) {
  //       return SafeArea(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * .6,
  //           width: MediaQuery.of(context).size.width,
  //           color: Colors.white,
  //           child: Text("SEARCH HERE"),
  //         ),
  //       );
  //     },
  //     // elevation: 0,
  //   );
  // }

  void _goToDetailArticle(BuildContext context, Article article) async {
    final articleService = Provider.of<ArticleService>(context, listen: false);
    Navigator.of(context)
        .push(
          CupertinoPageRoute(
            builder: (context) => ArticleDetailPage(
              article: article,
              articleService: articleService,
            ),
          ),
        )
        .then((value) => setState(() {}));
  }

  List<Widget> savedArticlesWidget() {
    List<Widget> tempWidget = [];
    if (_articleService == null) return tempWidget;
    _articleService.savedArticles
        .map((Article article) => tempWidget.add(
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _goToDetailArticle(context, article),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          article.thumbnail,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 90,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            Text(
                              article.author,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            Text(
                              article.date,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    return tempWidget;
  }

  Widget buildListSavedArticles() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Row(children: [
              Icon(Icons.bookmark),
              SizedBox(width: 10),
              Text(
                "Artikel tersimpan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            SizedBox(height: 20),
            Column(children: savedArticlesWidget())
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetListDataAndroid(BuildContext context) {
    print("_buildWidgetListDataAndroid()");
    return RefreshIndicator(
      onRefresh: getListData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          // InkWell(
          //   onTap: () => _showModalBottomSheet(context),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //     margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(30),
          //       // color: Colors.red,
          //       border: Border.all(color: Colors.black45, width: 1),
          //       // border: BoxBorder.
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.search,
          //           color: Colors.black45,
          //         ),
          //         SizedBox(width: 10),
          //         Text(
          //           "Cari artikel...",
          //           style: TextStyle(fontSize: 16, color: Colors.black45),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          PopularCategories(isLoading: isLoading),
          SizedBox(height: 5),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                Column(
                  children: [
                    ArticleSection(
                      endpointUrl: ApiEndpoint.KONSULTASI_SYARIAH,
                      title: "Konsultasi Syariah",
                      onTap: () {
                        _articleService.loadSavedArticles();
                        setState(() {});
                      },
                      articleService: _articleService,
                    ),
                    ArticleSection(
                      endpointUrl: ApiEndpoint.MUSLIMORID,
                      title: "Muslim.or.id",
                      onTap: () {
                        _articleService.loadSavedArticles();
                        setState(() {});
                      },
                      articleService: _articleService,
                    )
                  ],
                ),
                SizedBox(height: 10),
                buildListSavedArticles()
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      key: _drawerKey,
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _drawerKey.currentState.openDrawer(),
          // color: Colors.white,
        ),
        // backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "Artikel Islam",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            // icon: Icon(Icons.nights_stay_outlined),
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => SelectCategoryPage(
                    articleService: _articleService,
                    isConnected: isConnected,
                  ),
                )),
            color: Colors.white,
          ),
          // IconButton(
          //   // icon: Icon(Icons.wb_sunny_outlined),
          //   icon: Icon(Icons.nights_stay_outlined),
          //   onPressed: () {},
          //   color: Colors.white,
          // ),
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BookmarkPage(
                  articleService: _articleService,
                ),
              ),
            ).then((value) => setState(() {})),
            color: Colors.white,
          )
        ],
      ),
      body: Platform.isIOS
          ? Container()
          : Provider.value(
              value: isLoading,
              updateShouldNotify: (_, __) => true,
              child: _buildWidgetListDataAndroid(context),
            ),
    );
  }
}
