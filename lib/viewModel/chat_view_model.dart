import 'package:ira_app/models/message.dart';

class ChatViewModel {
  Message _message;
  ChatViewModel({Message message}) : this._message = message;

  String get content => _message.message;
  // User get user => _message.user;
  String get op => _message.op;
  bool get file => _message.file;
  String get fileType => _message.file_type;
  bool get seen => _message.seen;
  String get whoType => _message.whoType;
  String get createdAt => _message.createdAt;
}
