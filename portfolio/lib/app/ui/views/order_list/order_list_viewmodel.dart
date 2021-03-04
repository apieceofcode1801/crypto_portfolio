import 'package:intl/intl.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class OrderListViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  Future loadOrders([String portfolioId, String coinId]) async {
    setState(ViewState.Busy);
    _orders = await _databaseService.getOrdersOfPortfolio(portfolioId);
    if (coinId != null) {
      _orders = _orders.where((element) => element.coinId == coinId).toList();
    }
    _orders.sortByDate();
    setState(ViewState.Idle);
  }
}

extension OrderListExtension on List<Order> {
  void sortByDate() {
    DateFormat format = DateFormat('M/d/yyyy');
    this.sort((a, b) => format.parse(b.date).compareTo(format.parse(a.date)));
  }
}
