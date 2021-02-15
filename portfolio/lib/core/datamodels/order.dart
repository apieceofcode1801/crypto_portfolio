import 'package:portfolio/core/datamodels/coin.dart';
import 'package:portfolio/core/enums/order_type.dart';

class Order {
  int id;
  OrderType type;
  Coin coin;
  DateTime date;
  double amount;
  double price;

  Order({this.id, this.type, this.coin, this.date, this.amount, this.price});
}
