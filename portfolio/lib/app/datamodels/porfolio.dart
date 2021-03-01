class Portfolio {
  String id;
  String name;
  String createdAt;
  String updatedAt;

  Portfolio({this.id, this.name, this.createdAt, this.updatedAt});

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Portfolio copy({String name, String createdAt, String updatedAt}) {
    return Portfolio(
        id: this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
