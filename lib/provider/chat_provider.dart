import 'package:flutter/foundation.dart';
import 'package:ira_app/models/message.dart';
import 'package:ira_app/service/AuthService.dart';

class ChatProvider with ChangeNotifier {
  List<Message> messages = [];
  bool loading = true;
  getMessages() async {
    setLoading(true);
    await AuthService.shared.fetchMessageList().then((messages) {
      setMessages(messages);
      setLoading(false);
    }).catchError((e) {
      throw e;
    });
  }

  int get messageCount {
    return messages == null ? 0 : messages.length;
  }

  void setMessages(value) {
    messages = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void addMessage(
      {String contentMessage,
      String op,
      bool file,
      String fileType,
      String whoType}) {
    final message = Message(
        message: contentMessage,
        op: op,
        file: file,
        file_type: fileType,
        whoType: whoType);
    messages.add(message);
    notifyListeners();
  }
}
