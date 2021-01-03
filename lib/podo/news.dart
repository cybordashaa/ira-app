class News {
  List<NewsList> newsLists;

  News({this.newsLists});

  News.fromJson(Map<String, dynamic> json) {
    if (json['newsLists'] != null) {
      String t = json['newsLists'].runtimeType.toString();
      if (t == "List<dynamic>" || t == "_GrowableList<dynamic>") {
        newsLists = new List<NewsList>();
        json['newsLists'].forEach((v) {
          newsLists.add(new NewsList.fromJson(v));
        });
      } else {
        newsLists = new List<NewsList>();
        newsLists.add(new NewsList.fromJson(json['newsLists']));
      }
    }
  }
}

class NewsList {
  String title;
  String text;
  String id;
  String image;
  DateTime createdAt;

  NewsList({this.id, this.title, this.text, this.image, this.createdAt});

  NewsList.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? json['_id'] : null;
    title = json['title'] != null ? json['title'] : null;
    text = json['text'] != null ? json['text'] : null;
    image = json['image'] != null ? json['image'] : null;
    createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String);
  }
}
