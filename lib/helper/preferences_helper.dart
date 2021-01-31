import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferences _prefs;
  static var shared = SharedPreferencesHelper();

  // user control

  void userControl({void Function(bool) completionHandler}) async {
    _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    if (token != null) {
      completionHandler(true);
    } else {
      completionHandler(false);
    }
  }

  // Return token
  Future<String> getUserToken() async {
    _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    return token;
  }

  Future<String> getUserEmail() async {
    _prefs = await SharedPreferences.getInstance();
    var email = _prefs.getString('email');
    return email;
  }

  // return myId
  Future<String> getMyID() async {
    _prefs = await SharedPreferences.getInstance();
    var id = _prefs.getString('myID');
    return id;
  }

  // Remove Token and ID
  Future<void> removeToken() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('token');
    _prefs.remove('myID');
  }
}
