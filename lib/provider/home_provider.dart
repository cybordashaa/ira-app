import 'package:flutter/foundation.dart';
import 'package:ira_app/podo/news.dart';
import 'package:ira_app/service/ApiService.dart';

class HomeProvider with ChangeNotifier {
  News news = News();
  bool loading = true;

  getFetchNewsList() async {
    setLoading(true);
    Api.getNews(Api.newsURL).then((news) {
      setNews(news);
      setLoading(false);
    }).catchError((e) {
      throw e;
    });
  }

  int get newsCount {
    return news.newsLists == null ? 0 : news.newsLists.length;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setNews(value) {
    news = value;
    notifyListeners();
  }

  News getNews() {
    return news;
  }
}
