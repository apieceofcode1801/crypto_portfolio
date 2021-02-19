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
    _database = await openDatabase(
      DB_NAME,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(createPortfolioTableQuery);
        await db.execute(createOrderTableQuery);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute(createOrderPortfolioRelationQuery);
      },
    );
  }

  Future<List<Order>> getOrders() async {
    List<Map> orderResults = await _database.query(OrderTableName);

    return orderResults.map((e) => Order.fromJson(e)).toList();
  }

  Future addOrder(
      {String coinId, int type, String date, num amount, num price}) async {
    try {
      await _database.insert(
          OrderTableName,
          Order(
                  coinId: coinId,
                  type: type,
                  date: date,
                  amount: amount,
                  price: price)
              .toJson());
    } catch (e) {
      print('Coudn\'t insert the order: $e');
    }
  }

  Future updateOrder(
      {int id, int type, DateTime date, double amount, double price}) async {
    try {
      await _database.update(
          OrderTableName,
          {
            'type': type,
            'date': date,
            'amount': amount,
            'price': price,
          },
          where: 'id = ?',
          whereArgs: [id]);
    } catch (e) {
      print('Could not update order: $e');
    }
  }

  Future<List<Portfolio>> getPortfolios() async {
    List<Map> portfolioResults = await _database.query(PortfolioTableName);
    return portfolioResults.map((e) => Portfolio.fromJson(e)).toList();
  }

  Future addPortfolio(Portfolio portfolio) async {
    try {
      await _database.insert(PortfolioTableName, portfolio.toJson());
    } catch (e) {
      print('Could not add portfolio');
    }
  }

  Future updatePortfolio(int id, String name) async {
    try {
      await _database.update(
          PortfolioTableName, {'name': name, 'updated_at': DateTime.now()});
    } catch (e) {
      print('Could not update portfolio: $e');
    }
  }
}
