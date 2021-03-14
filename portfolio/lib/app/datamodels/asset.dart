class Asset {
  String coinId;
  String coinSymbol;
  double amount;
  double total;
  double curPrice;

  double get avgPrice => total / amount;
  double get marketTotal => amount * curPrice;
  double get profit => (curPrice - avgPrice) / avgPrice;

  Asset({this.coinSymbol, this.coinId, this.amount, this.total, this.curPrice});
}
