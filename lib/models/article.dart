import 'package:artikel_islam/constants/strings.dart';

class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String author;
  final String author_link;
  final String date;
  final String date_time;
  final String content_html;

  Article({
    this.id,
    this.author,
    this.author_link,
    this.thumbnail,
    this.date,
    this.date_time,
    this.title,
    this.content_html = "",
  });

  factory Article.fromJson(Map<String, dynamic> data) {
    return Article(
      id: data["id"] ?? "",
      title: data["title"] ?? "",
      thumbnail: data["thumbnail"] ?? IMAGE_PLACEHOLDER,
      author: data["author"] ?? "Author",
      author_link: data["author_link"] ?? "",
      date: data["date"] ?? "",
      date_time: data["date_time"] ?? "",
      content_html: data["content_html"] ?? "",
    );
  }

  @override
  Map toMap() {
    // TODO: implement toString
    Map<String, dynamic> data = {
      "id": this.id,
      "title": this.title,
      "thumbnail": this.thumbnail,
      "author": this.author,
      "author_link": this.author_link,
      "date": this.date,
      "date_time": this.date_time,
      "content_html": this.content_html,
    };
    return data;
  }
}
