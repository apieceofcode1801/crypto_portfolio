import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/ui/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/locator.dart';

class OrderModel extends BaseViewModel {
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  DatabaseService _databaseService = locator<DatabaseService>();

  void loadOrders() async {
    setState(ViewState.Busy);
    _orders = await _databaseService.getOrders();
    setState(ViewState.Idle);
  }

  Future<bool> addOrder(
      {String coinId, int type, num amount, num price}) async {
    setState(ViewState.Busy);
    final date = DateTime.now().toString();
    final id = await _databaseService.addOrder(
        coinId: coinId, type: type, date: date, amount: amount, price: price);
    _orders.add(Order(
        id: id,
        coinId: coinId,
        type: type,
        date: date,
        amount: amount,
        price: price));
    setState(ViewState.Idle);
    return true;
  }
}
