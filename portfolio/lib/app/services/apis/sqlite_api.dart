import 'package:portfolio/app/datamodels/alert.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/services/apis/db_api_abstract.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../database_service_helper.dart';

const String DB_NAME = 'portfolio.sqlite';
const String OrderTableName = 'orders';
const String PortfolioTableName = 'portfolios';

class SqliteApi extends DbApiAbstract {
  Database _database;

  Future initialise() async {
    _database =
        await openDatabase(DB_NAME, version: 1, onCreate: (db, version) async {
      await db.execute(createPortfolioTableQuery);
      await db.execute(createOrderTableQuery);
    });
  }

  Future<List<Order>> getOrders() async {
    List<Map> orderResults = await _database.query(OrderTableName);
    return orderResults.map((e) => Order.fromJson(e)).toList();
  }

  Future<List<Order>> getOrdersOfPortfolio(String id) async {
    List<Map> results = await _database
        .rawQuery('SELECT * FROM $OrderTableName WHERE portfolio_id = $id');
    return results.map((e) => Order.fromJson(e)).toList();
  }

  Future<int> addOrder(Order order) async {
    try {
      return await _database.insert(OrderTableName, order.toJson());
    } catch (e) {
      print('Coudn\'t insert the order: $e');
      return 0;
    }
  }

  Future updateOrder({String id, Order order}) async {
    try {
      await _database.update(OrderTableName, order.toJson(),
          where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not update order: $e');
    }
  }

  Future deleteOrder({String id}) async {
    try {
      await _database.delete(OrderTableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not delete order: $e');
    }
  }

  Future<List<Portfolio>> getPortfolios({String userId}) async {
    List<Map> portfolioResults = await _database.query(PortfolioTableName);
    return portfolioResults.map((e) => Portfolio.fromJson(e)).toList();
  }

  Future addPortfolio({Portfolio portfolio}) async {
    try {
      await _database.insert(PortfolioTableName, portfolio.toJson());
    } catch (e) {
      print('Could not add portfolio');
    }
  }

  Future updatePortfolio(String id, Portfolio portfolio) async {
    try {
      await _database.update(PortfolioTableName, portfolio.toJson(),
          where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not update portfolio: $e');
    }
  }

  Future deletePortfolio(String id) async {
    try {
      await _database
          .delete(PortfolioTableName, where: 'id = ?', whereArgs: [id]);
      await _database
          .delete(OrderTableName, where: 'portfolio_id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not delete portfolio: $e');
    }
  }

  @override
  Future<List<Order>> getOrdersOfAsset(String portfolioId, {String coinId}) {
    // TODO: implement getOrdersOfAsset
    throw UnimplementedError();
  }

  @override
  Future addAlert(Alert alert) {
    // TODO: implement addAlert
    throw UnimplementedError();
  }

  @override
  Future deleteAlert({String id}) {
    // TODO: implement deleteAlert
    throw UnimplementedError();
  }

  @override
  Future<List<Alert>> getAlertsForAsset(String portfolioId, {String coinId}) {
    // TODO: implement getAlertsForAsset
    throw UnimplementedError();
  }

  @override
  Future updateAlert(Alert alert) {
    // TODO: implement updateAlert
    throw UnimplementedError();
  }
}
