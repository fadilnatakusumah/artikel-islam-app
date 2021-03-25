class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String date;
  final String date_time;

  Article({this.id, this.thumbnail, this.date, this.date_time, this.title});

  factory Article.fromJson(Map<String, dynamic> data){
    return Article(
      id: data["id"],
      title: data["title"],
      thumbnail: data["thumbnail"],
      date: data["date"],
      date_time: data["date_time"],
    );
  }
}