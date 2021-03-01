import 'package:flutter/foundation.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/services/apis/db_api_abstract.dart';
import 'package:portfolio/app/services/apis/sqlite_api.dart';
import 'package:portfolio/app/services/apis/firestore_api.dart';

class DatabaseService {
  DbApiAbstract _api;

  DatabaseService() {
    if (kIsWeb) {
      _api = FirestoreApi();
    } else {
      _api = SqliteApi();
    }
  }

  Future addOrder(Order order) {
    return _api.addOrder(order);
  }

  Future addPortfolio({Portfolio portfolio}) {
    return _api.addPortfolio(portfolio: portfolio);
  }

  Future deleteOrder({String id}) {
    return _api.deleteOrder(id: id);
  }

  Future deletePortfolio(String id) {
    return _api.deletePortfolio(id);
  }

  Future<List<Order>> getOrders() {
    return _api.getOrders();
  }

  Future<List<Order>> getOrdersOfPortfolio(String id) {
    return _api.getOrdersOfPortfolio(id);
  }

  Future<List<Portfolio>> getPortfolios() {
    return _api.getPortfolios();
  }

  Future initialise() {
    return _api.initialise();
  }

  Future updateOrder({String id, Order order}) {
    return _api.updateOrder(id: id, order: order);
  }

  Future updatePortfolio(String id, Portfolio portfolio) {
    return _api.updatePortfolio(id, portfolio);
  }
}
