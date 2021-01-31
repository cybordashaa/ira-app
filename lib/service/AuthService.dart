import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ira_app/helper/preferences_helper.dart';
import 'package:ira_app/models/message.dart';

class AuthService {
  static final shared = AuthService();
  String host = "http://192.168.1.4:8001/";
  postData(data, apiUrl) async {
    var fullUrl = host + apiUrl;
    return await http
        .post(fullUrl, body: jsonEncode(data), headers: _setHeaders())
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('Дахин оролдоно уу');
    });
  }

  authPostData(data, apiUrl, token) async {
    var fullUrl = host + apiUrl;
    return await http.post(fullUrl, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<List<dynamic>> fetchMessageList() async {
    var myID = await SharedPreferencesHelper.shared.getMyID();
    var token = await SharedPreferencesHelper.shared.getUserToken();
    var email = await SharedPreferencesHelper.shared.getUserEmail();
    var body = {"useremail": email};
    var response = await this.authPostData(body, 'chatroom', token);
    if (response.statusCode == 200) {
      var list = (json.decode(response.body)['messages'] as List)
          .map((e) => Message.fromJson(e))
          .toList();
      // var data = json.decode(response.body['roomMessages']);
      // List<Message> list = List<Message>.from(data)
      //     .map((Map model) => Message.fromJson(model))
      //     .toList();
      // print("----${list[2].message.split(',')[1]}");
      return list;
    } else {
      return List<Message>();
    }
  }
}
