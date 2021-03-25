class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String date;
  final String date_time;

  Article({
    required this.id,
    required this.author,
    required this.author_link,
    required this.thumbnail,
    required this.date,
    required this.date_time,
    required this.title,
    this.content_html = "",
  });

  factory Article.fromJson(Map<String, dynamic> data) {
    return Article(
      id: data["id"],
      title: data["title"],
      thumbnail: data["thumbnail"],
      date: data["date"],
      date_time: data["date_time"],
    );
  }
}
