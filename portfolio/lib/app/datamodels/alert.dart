class Alert {
  String id;
  String portfolioId;
  String coinId;
  String label;
  double price;

  Alert({this.id, this.portfolioId, this.coinId, this.label, this.price});

  Alert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    portfolioId = json['portfolio_id'];
    coinId = json['coin_id'];
    label = json['label'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'portfolio_id': portfolioId,
      'coin_id': coinId,
      'label': label,
      'price': price
    };
  }

  Alert copy({String portfolioId, String coinId, String label, double price}) {
    return Alert(
        id: this.id,
        portfolioId: portfolioId ?? this.portfolioId,
        coinId: coinId ?? this.coinId,
        label: label ?? this.label,
        price: price ?? this.price);
  }
}
