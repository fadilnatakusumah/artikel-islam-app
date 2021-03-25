import 'dart:async';

import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'article_detail_page.dart';

// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final ArticleService _articleService =
//     // Provider.of<ArticleService
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Theme.of(context).accentColor,
//         centerTitle: true,
//         title: Text(
//           "Pilih website",
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.search_rounded),
//               onPressed: () {
//                 // showSearch(context: context, delegate: DataSearch(_articleS));
//               })
//         ],
//       ),
//       body: Center(child: Text("SEARCH PAGE")),
//     );
//   }
// }

class DataSearch extends SearchDelegate<Map<dynamic, String>> {
  final ArticleService articleService;
  final CategoryArticle categoryArticle;
  Timer? _debounce;

  DataSearch({
    required this.articleService,
    required this.categoryArticle,
  });

  List<Article> _articles = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final themeData = Theme.of(context);
    return themeData.copyWith(
      primaryColor: themeData.accentColor,
      // hintColor: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.white,
      ),
      onPressed: () => close(context, {}),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return _futureBuilder();
  }

  void _goToDetailArticle(BuildContext context, Article article) async {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            ArticleDetailPage(
              article: article,
              endpoint: categoryArticle.endpointUrl,
              articleService: articleService,
            ),
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> _futureBuilder() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var data = snapshot.data!["data"] as List<Article>;
          if (data.length == 0) {
            return Center(
              child: Text(
                "Artikel tidak ditemukan",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            );
          }
          final articles = data;
          return ListView.builder(
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: () => _goToDetailArticle(context, articles[index]),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.network(
                      articles[index].thumbnail,
                      width: 100,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        articles[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articles[index].author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        //   child: Text(","),
                        // ),
                        Text(
                          articles[index].date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            itemCount: articles.length,
          );
        }
        return Container();
      },
      future: articleService.searchArticle(
        categoryArticle: categoryArticle,
        params: {"query": query},
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }

    return _futureBuilder();

    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     leading: Image.network(_articles[index].thumbnail),
    //     title: Text(_articles[index].title),
    //     subtitle: Row(
    //       children: [
    //         Text(
    //           _articles[index].author,
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(
    //           width: 10,
    //           child: Text(","),
    //         ),
    //         Text(_articles[index].date)
    //       ],
    //     ),
    //   ),
    //   itemCount: _articles.length,
    // );
  }
}

// class DummyDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) => [];
//
//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//     icon: Icon(Icons.close),
//     onPressed: () => Navigator.of(context).pop(),
//   );
//
//   @override
//   Widget buildResults(BuildContext context) => Text('Result');
//
//   @override
//   Widget buildSuggestions(BuildContext context) => Text('Suggestion');
// }

class CustomLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(en_US)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "Cari Artikel";
}
