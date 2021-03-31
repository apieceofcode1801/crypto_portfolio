import 'package:portfolio/app/datamodels/alert.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/services/apis/db_api_abstract.dart';

class DatabaseService {
  final DbApiAbstract api;

  DatabaseService({this.api});

  Future addOrder(Order order) {
    return api.addOrder(order);
  }

  Future addPortfolio({Portfolio portfolio}) {
    return api.addPortfolio(portfolio: portfolio);
  }

  Future deleteOrder({String id}) {
    return api.deleteOrder(id: id);
  }

  Future deletePortfolio(String id) {
    return api.deletePortfolio(id);
  }

  Future<List<Order>> getOrders() {
    return api.getOrders();
  }

  Future<List<Order>> getOrdersOfPortfolio(String id) {
    return api.getOrdersOfPortfolio(id);
  }

  Future<List<Portfolio>> getPortfolios({String userId}) {
    return api.getPortfolios(userId: userId);
  }

  Future initialise() {
    return api.initialise();
  }

  Future updateOrder({String id, Order order}) {
    return api.updateOrder(id: id, order: order);
  }

  Future updatePortfolio(String id, Portfolio portfolio) {
    return api.updatePortfolio(id, portfolio);
  }

  Future<List<Order>> getOrdersForAsset({String portfolioId, String coinId}) {
    return api.getOrdersOfAsset(portfolioId, coinId: coinId);
  }

  Future addAlert(Alert alert) {
    return api.addAlert(alert);
  }

  Future deleteAlert({String id}) {
    return api.deleteAlert(id: id);
  }

  Future updateAlert(Alert alert) {
    return api.updateAlert(alert);
  }

  Future<List<Alert>> getAlertsForAsset(String portfolioId, {String coinId}) {
    return api.getAlertsForAsset(portfolioId, coinId: coinId);
  }
}
