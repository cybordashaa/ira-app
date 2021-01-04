class UserData {
  String avatar;
  int wallet;
  String id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String address;

  UserData(
      {this.avatar,
      this.wallet,
      this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.address});

  UserData.fromJson(Map<String, dynamic> json) {
    avatar = json['user']['avatar'] ?? '';
    wallet = json['user']['wallet'] ?? 0;
    id = json['user']['_id'] ?? '';
    firstname = json['user']['firstname'] ?? '';
    lastname = json['user']['lastname'] ?? '';
    email = json['user']['email'] ?? '';
    phone = json['user']['phone'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['wallet'] = this.wallet;
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
