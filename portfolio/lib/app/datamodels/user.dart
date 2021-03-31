class User {
  String id;
  String username;
  String password;

  User({this.id, this.username, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'password': password};
  }

  User copy({String username}) {
    return User(id: this.id, username: username ?? this.username);
  }
}
