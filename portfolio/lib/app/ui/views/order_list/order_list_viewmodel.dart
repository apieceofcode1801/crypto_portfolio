import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class OrderListViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  Future loadOrders([String portfolioId]) async {
    setState(ViewState.Busy);
    _orders = await _databaseService.getOrdersOfPortfolio(portfolioId);
    _orders.sortByDate();
    setState(ViewState.Idle);
  }

  Future deleteOrder(Order order) async {
    await _databaseService.deleteOrder(id: order.id.toString());
  }
}
