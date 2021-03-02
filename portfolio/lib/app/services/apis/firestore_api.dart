import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/services/apis/db_api_abstract.dart';

class FirestoreApi extends DbApiAbstract {
  final _portfolios = FirebaseFirestore.instance.collection('_portfolios');
  final _orders = FirebaseFirestore.instance.collection('orders');
  @override
  Future addOrder(Order order) {
    final ref = _orders.doc();
    order.id = ref.id;
    return ref.set(order.toJson());
  }

  @override
  Future addPortfolio({Portfolio portfolio}) {
    final ref = _portfolios.doc();
    portfolio.id = ref.id;
    return ref.set(portfolio.toJson());
  }

  @override
  Future deleteOrder({String id}) {
    return _orders
        .doc(id)
        .delete()
        .then((value) => print('Order deleted'))
        .catchError((err) => print('Order deleted fail: $err'));
  }

  @override
  Future deletePortfolio(String id) {
    return _portfolios
        .doc(id)
        .delete()
        .then((value) => print('Portfolio deleted'))
        .catchError((err) => print('Portfolio deleted fail: $err'));
  }

  @override
  Future<List<Order>> getOrders() {
    return _orders.get().then(
        (value) => value.docs.map((e) => Order.fromJson(e.data())).toList());
  }

  @override
  Future<List<Order>> getOrdersOfPortfolio(String id) {
    return _orders.where('portfolio_id', isEqualTo: id).get().then((value) {
      return value.docs.map((e) => Order.fromJson(e.data())).toList();
    });
  }

  @override
  Future<List<Portfolio>> getPortfolios({String userId}) {
    return _portfolios.where('user_id', isEqualTo: userId).get().then((value) =>
        value.docs.map((e) => Portfolio.fromJson(e.data())).toList());
  }

  @override
  Future initialise() {
    return Future.value(null);
  }

  @override
  Future updateOrder({String id, Order order}) {
    return _orders
        .doc(id)
        .set(order.toJson())
        .then((value) => print('Order updated'))
        .catchError((err) => print('Order updated error: $err'));
  }

  @override
  Future updatePortfolio(String id, Portfolio portfolio) {
    return _portfolios
        .doc(id)
        .set(portfolio.toJson())
        .then((value) => print('Portfolio updated'))
        .catchError((err) => print('Portfolio updated error: $err'));
  }
}
