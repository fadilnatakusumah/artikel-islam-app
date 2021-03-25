import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/helpers/internetConnection.dart';
import 'package:artikel_islam/pages/articles.dart';
import 'package:artikel_islam/pages/categories.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCategories extends StatelessWidget {
  final bool isLoading;
  final ArticleService articleService;

  const PopularCategories({
    Key? key,
    required this.isLoading,
    required this.articleService,
  }) : super(key: key);

  List<Widget> _renderCategories(BuildContext context) {
    return LIST_CATEGORIES.map((CategoryArticle category) {
      return GestureDetector(
        onTap: () => Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => ArticlesPage(
                  categoryArticle: category,
                  articleService: articleService,
                ),
              ),
            ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(right: 5),
          child: Text(
            category.name,
            style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print("isLoading $isLoading");
    return Container(
      padding: EdgeInsets.all(10),
      height: Size.fromHeight(50).height,
      child: isLoading
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  color: Colors.grey[600],
                );
              },
              itemCount: 4,
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              children: _renderCategories(context),
              // [
              //   Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     margin: EdgeInsets.only(right: 5),
              //     child: Text(
              //       "Konsultasi Syariah",
              //       style: TextStyle(
              //           color: Colors.white,
              //           // fontWeight: FontWeight.bold,
              //           fontSize: 15),
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.black54,
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     margin: EdgeInsets.only(right: 5),
              //     child: Text(
              //       "Muslim.or.id",
              //       style: TextStyle(
              //         color: Colors.white,
              //         // fontWeight: FontWeight.bold,
              //         fontSize: 15,
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.black54,
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     margin: EdgeInsets.only(right: 5),
              //     child: Text(
              //       "Muslimah.or.id",
              //       style: TextStyle(
              //           color: Colors.white,
              //           // fontWeight: FontWeight.bold,
              //           fontSize: 15),
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.black54,
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   // Container(
              //   //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   //   margin: EdgeInsets.only(right: 5),
              //   //   child: Text(
              //   //     "Rumaysho",
              //   //     style: TextStyle(
              //   //         color: Colors.white,
              //   //         // fontWeight: FontWeight.bold,
              //   //         fontSize: 15),
              //   //   ),
              //   //   decoration: BoxDecoration(
              //   //     color: Colors.black54,
              //   //     borderRadius: BorderRadius.circular(5),
              //   //   ),
              //   // ),
              //   // Container(
              //   //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   //   margin: EdgeInsets.only(right: 5),
              //   //   child: Text(
              //   //     "Firanda.com",
              //   //     style: TextStyle(
              //   //         color: Colors.white,
              //   //         fontWeight: FontWeight.bold,
              //   //         fontSize: 15),
              //   //   ),
              //   //   decoration: BoxDecoration(
              //   //       color: Colors.lightBlueAccent,
              //   //       borderRadius: BorderRadius.circular(20)),
              //   // ),
              // ],
            ),
    );
  }
}
