import 'package:portfolio/app/datamodels/alert.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';

abstract class DbApiAbstract {
  Future initialise();
  Future<List<Order>> getOrders();
  Future<List<Order>> getOrdersOfPortfolio(String id);
  Future<List<Order>> getOrdersOfAsset(String portfolioId, {String coinId});
  Future addOrder(Order order);
  Future updateOrder({String id, Order order});
  Future deleteOrder({String id});
  Future<List<Portfolio>> getPortfolios({String userId});
  Future addPortfolio({Portfolio portfolio});
  Future updatePortfolio(String id, Portfolio portfolio);
  Future deletePortfolio(String id);

  Future addAlert(Alert alert);
  Future deleteAlert({String id});
  Future updateAlert(Alert alert);
  Future<List<Alert>> getAlertsForAsset(String portfolioId, {String coinId});
}
