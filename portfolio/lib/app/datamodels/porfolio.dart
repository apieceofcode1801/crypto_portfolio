class Portfolio {
  String id;
  String name;
  String userId;
  String createdAt;
  String updatedAt;

  Portfolio({this.id, this.userId, this.name, this.createdAt, this.updatedAt});

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Portfolio copy({String name, String createdAt, String updatedAt}) {
    return Portfolio(
        id: this.id,
        userId: this.userId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
