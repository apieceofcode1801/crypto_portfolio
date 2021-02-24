import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'database_service_helper.dart';

const String DB_NAME = 'portfolio.sqlite';
const String OrderTableName = 'orders';
const String PortfolioTableName = 'portfolios';

class DatabaseService {
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

  Future<List<Order>> getOrdersOfPortfolio(int id) async {
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

  Future updateOrder({int id, Order order}) async {
    try {
      await _database.update(OrderTableName, order.toJson(),
          where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not update order: $e');
    }
  }

  Future deleteOrder({int id}) async {
    try {
      await _database.delete(OrderTableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not delete order: $e');
    }
  }

  Future<List<Portfolio>> getPortfolios() async {
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

  Future updatePortfolio(int id, Portfolio portfolio) async {
    try {
      await _database.update(PortfolioTableName, portfolio.toJson(),
          where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not update portfolio: $e');
    }
  }

  Future deletePortfolio(int id) async {
    try {
      await _database
          .delete(PortfolioTableName, where: 'id = ?', whereArgs: [id]);
      await _database
          .delete(OrderTableName, where: 'portfolio_id = ?', whereArgs: [id]);
    } catch (e) {
      print('Could not delete portfolio: $e');
    }
  }
}
