import 'package:artikel_islam/helpers/stringStripHtml.dart';
import 'package:artikel_islam/models/article.dart';
import 'package:artikel_islam/pages/article_detail_page.dart';
import 'package:artikel_islam/services/locals/article_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  final ArticleService articleService;

  const BookmarkPage({Key? key, required this.articleService})
      : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  void _goToDetailArticle(BuildContext context, Article article) async {
    Navigator.of(context)
        .push(
          CupertinoPageRoute(
            builder: (context) => ArticleDetailPage(
              article: article,
              articleService: widget.articleService,
            ),
          ),
        )
        .then((value) => setState(() {}));
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Article _article = widget.articleService.savedArticles[index];
        return ListTile(
          onTap: () => _goToDetailArticle(context, _article),
          contentPadding: EdgeInsets.all(10),
          leading: Image.network(
            _article.thumbnail,
            width: 100,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              _article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            "${stringStripHtml(_article.content_html).substring(0, 100)}...",
            style: TextStyle(fontSize: 13),
          ),
        );

        return ListTile(
          // contentPadding: EdgeInsets.only(),
          onTap: () => _goToDetailArticle(context, _article),
          leading: Image.network(
            _article.thumbnail,
            fit: BoxFit.cover,
            width: 100,
          ),
          // Image.network(
          //   article.thumbnail,
          //   fit: BoxFit.cover,
          //   height: 70,
          //   width: 90,
          // ),
          title: Text(
            _article.title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "${stringStripHtml(_article.content_html).substring(0, 100)}...",
            style: TextStyle(fontSize: 13),
          ),
        );
      },
      itemCount: widget.articleService.savedArticles.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "Artikel tersimpan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildListView(context),
    );
  }
}
