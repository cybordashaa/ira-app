import 'dart:convert';

import 'package:ira_app/helper/preferences_helper.dart';
import 'package:ira_app/podo/news.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseURL = 'http://192.168.1.4:8001';
  static String newsURL = baseURL + '/admin/news/all';

  static Future<News> getNews(String url) async {
    var token = await SharedPreferencesHelper.shared.getUserToken();
    var res = await http.get(url, headers: {'Authorization': 'Bearer $token'});

    News news;
    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      news = News.fromJson(jsonResponse);
    } else {
      throw ("Error ${res.statusCode}");
    }
    return news;
  }
}
