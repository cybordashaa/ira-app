import 'package:http/http.dart' as http;

class DatabaseHelper {
  String host = "http://192.168.0.111:8001/";

  var data;

  static final String token = null;
  Future<dynamic> signUp(String firstName, String lastName, String email,
      String password, String phone) async {
    Map body = {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "password": password,
      "phone": phone
    };
    print("${body}");
    String registerUrl = "${host}user/register";
    var res = await http.post(registerUrl, body: body);
    return res?.body;
    // data = json.decode(res.body);
    // return data;
  }
}
