class Order {
  int id;
  int type;
  String coinId;
  String date;
  num amount;
  num price;

  Order({this.id, this.type, this.coinId, this.date, this.amount, this.price});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    coinId = json['coin_id'];
    date = json['date'];
    amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['coin_id'] = coinId;
    data['date'] = date;
    data['amount'] = amount;
    data['price'] = price;
    return data;
  }
}
