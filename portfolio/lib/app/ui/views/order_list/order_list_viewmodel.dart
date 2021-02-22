import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class OrderListViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  Future loadOrders(int portfolioId) async {
    setState(ViewState.Busy);
    _orders = await _databaseService.getOrdersOfPortfolio(portfolioId);
    setState(ViewState.Idle);
  }
}
