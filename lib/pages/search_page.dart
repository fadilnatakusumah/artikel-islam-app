import 'dart:async';

import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/helpers/stringStripHtml.js.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Timer _debounce;

  DataSearch({this.articleService, this.categoryArticle});

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
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    throw UnimplementedError();
  }

  // Future<void> searchArticles(BuildContext context, String query) {
  //   print("articleServiec $articleService");
  //   if (query.isEmpty) {
  //     _articles = [];
  //     return;
  //   }
  //   if (_debounce?.isActive ?? false) _debounce.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () async {
  //     // if (articleService != null) return;
  //     try {
  //       print("QUERY $query");
  //       final list = await articleService.searchArticle(
  //         categoryArticle: categoryArticle,
  //         query: query,
  //       );
  //       _articles = list;
  //       showSuggestions(context);
  //     } catch (err) {
  //       print("error: $err");
  //     }
  //   });
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // searchArticles(context, query);
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        print("snapshot.connectionState ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text("Tidak terdapat kalender"),
            );
          }
          final articles = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.network(articles[index].thumbnail),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  articles[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    articles[index].author,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  // SizedBox(
                  //   width: 10,
                  //   child: Text(","),
                  // ),
                  Text(
                    articles[index].date,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            itemCount: articles.length,
          );
        }
        return Container();
      },
      future: articleService.searchArticle(
        categoryArticle: categoryArticle,
        query: query,
      ),
    );
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Image.network(_articles[index].thumbnail),
        title: Text(_articles[index].title),
        subtitle: Row(
          children: [
            Text(
              _articles[index].author,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
              child: Text(","),
            ),
            Text(_articles[index].date)
          ],
        ),
      ),
      itemCount: _articles.length,
    );
  }
}
