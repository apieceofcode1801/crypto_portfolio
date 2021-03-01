class Order {
  String id;
  int type;
  String coinId;
  String coinSymbol;
  String date;
  double amount;
  double price;
  String portfolioId;
  double get total => amount * price;

  Order(
      {this.id,
      this.type,
      this.coinId,
      this.coinSymbol,
      this.date,
      this.amount,
      this.price,
      this.portfolioId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    coinId = json['coin_id'];
    coinSymbol = json['coin_symbol'];
    date = json['date'];
    amount = json['amount'];
    price = json['price'];
    portfolioId = json['portfolio_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['coin_id'] = coinId;
    data['coin_symbol'] = coinSymbol;
    data['date'] = date;
    data['amount'] = amount;
    data['price'] = price;
    data['portfolio_id'] = portfolioId;
    return data;
  }

  Order copy(
      {int id,
      int type,
      String coinId,
      String coinSymbol,
      String date,
      double amount,
      double price,
      int portfolioId}) {
    return Order(
        id: id ?? this.id,
        type: type ?? this.type,
        coinId: coinId ?? this.coinId,
        coinSymbol: coinSymbol ?? this.coinSymbol,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        price: price ?? this.price,
        portfolioId: portfolioId ?? this.portfolioId);
  }
}
