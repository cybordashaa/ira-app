class Message {
  String message;
  String op;
  bool file;
  String file_type;
  bool seen;
  String whoType;
  String createdAt;

  Message({
    this.message,
    this.op,
    this.file,
    this.file_type,
    this.seen,
    this.whoType,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    op = json['operator'] ?? null;
    file = json['file'] ?? false;
    file_type = json['file_type'] ?? "";
    seen = json['seen'] ?? false;
    whoType = json['whoType'] ?? "";
    createdAt = json['createdAt'];
  }
}

class User {
  String avatar;
  bool online;
  String firstName;
  String lastName;
  String email;

  User({this.avatar, this.online, this.firstName, this.lastName, this.email});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    online = json['Online'] ?? false;
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
  }
}
