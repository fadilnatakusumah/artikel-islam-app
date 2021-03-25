import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/pages/article_detail_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final String endpoint;
  final VoidCallback onTap;

  ArticleCard({
    required this.article,
    required this.endpoint,
    required this.onTap,
  });

  void _goToDetailArticle(BuildContext context) async {
    final articleService = Provider.of<ArticleService>(context, listen: false);
    Navigator.of(context)
        .push(
      CupertinoPageRoute(
        builder: (context) => ArticleDetailPage(
          article: article,
          endpoint: endpoint,
          articleService: articleService,
        ),
      ),
    )
        .then((value) {
      if (value && onTap != null) onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      constraints: BoxConstraints(maxWidth: 180),
      margin: EdgeInsets.only(right: 18),
      child: InkWell(
        onTap: () => _goToDetailArticle(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                article.thumbnail,
                fit: BoxFit.cover,
                height: 100,
                width: 210,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 2),
                Text(
                  article.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return GestureDetector(
//     onTap: () => _goToDetailArticle(context),
//     child: Container(
//       // width: 215,
//       margin: EdgeInsets.only(right: 3),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(article.title)
//           // ClipRRect(
//           //   borderRadius: BorderRadius.circular(10),
//           //   child: Image.network(
//           //     article.thumbnail ??
//           //         "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg",
//           //     fit: BoxFit.cover,
//           //     height: 130,
//           //     width: 200,
//           //   ),
//           // ),
//           // Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Padding(
//           //       padding: const EdgeInsets.symmetric(vertical: 3.0),
//           //       child: Text(
//           //         article.title,
//           //         overflow: TextOverflow.visible,
//           //         style: TextStyle(
//           //           fontWeight: FontWeight.w700,
//           //           fontSize: 15,
//           //         ),
//           //       ),
//           //     ),
//           //     if (article.date != "")
//           //       Text(
//           //         article.date,
//           //         style: TextStyle(
//           //           fontSize: 12,
//           //         ),
//           //       ),
//           //     if (article.author != "")
//           //       Text(
//           //         article.author,
//           //         style: TextStyle(
//           //             fontSize: 12,
//           //             fontWeight: FontWeight.bold,
//           //             color: Colors.black54),
//           //       ),
//           //   ],
//           // )
//         ],
//       ),
//     ),
//   );
// }
}
