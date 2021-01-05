import 'package:flutter/foundation.dart';
import 'package:ira_app/models/user_data.dart';

class ProfileProvider extends ChangeNotifier {
  UserData userData = UserData();
  bool loading = true;
  getProfile(UserData data) {
    setLoading(true);
    setUserData(data);
    setLoading(false);
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUserData(value) {
    userData = value;
    notifyListeners();
  }

  UserData getUserData() {
    return userData;
  }
}
