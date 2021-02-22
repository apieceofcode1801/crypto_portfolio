// import 'package:portfolio/app/datamodels/order.dart';
// import 'package:portfolio/core/base_viewmodel.dart';

// class OrderModel extends BaseViewModel {
//   List<Order> _orders = [];
//   List<Order> get orders => _orders;

//   void setOrders(List<Order> orders) {
//     _orders = orders;
//     notifyListeners();
//   }

//   void addOrder(Order order) {
//     _orders.add(order);
//     notifyListeners();
//   }

//   void deleteOrder(Order order) {
//     _orders.remove(order);
//     notifyListeners();
//   }

//   // DatabaseService _databaseService = locator<DatabaseService>();

//   // Future<List<Order>> loadOrders(int portfolioId) async {
//   //   setState(ViewState.Busy);
//   //   final orders = await _databaseService.getOrdersOfPortfolio(portfolioId);
//   //   setState(ViewState.Idle);
//   //   return orders;
//   // }

//   // Future<bool> addOrder(
//   //     {@required String coinId,
//   //     @required String coinSymbol,
//   //     @required int type,
//   //     @required num amount,
//   //     @required num price,
//   //     @required int portfolioId}) async {
//   //   setState(ViewState.Busy);
//   //   final date = DateTime.now().toString();
//   //   final order = Order(
//   //       coinId: coinId,
//   //       coinSymbol: coinSymbol,
//   //       type: type,
//   //       date: date,
//   //       amount: amount,
//   //       price: price,
//   //       portfolioId: portfolioId);
//   //   await _databaseService.addOrder(order);
//   //   setState(ViewState.Idle);
//   //   return true;
//   // }
// }
