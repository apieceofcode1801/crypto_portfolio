import 'package:portfolio/core/datamodels/order.dart';
import 'package:portfolio/core/datamodels/porfolio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const String DB_NAME = 'portfolio.sqlite';
const String OrderTableName = 'orders';
const String PortfolioTableName = 'portfolios';

class DatabaseService {
  Database _database;

  Future initialise() async {
    final query = '''
      CREATE TABLE orders(
    id INTEGER PRIMARY KEY,
    type INTEGER,
    coin_id TEXT,
    date INTEGER,
    amount REAL,
    price REAL
);

CREATE TABLE porfolios {
    id INTEGER PRIMARY KEY,
    name TEXT,
    created_at INTEGER,
    updated_at INTEGER
}
    ''';

    _database =
        await openDatabase(DB_NAME, version: 1, onCreate: (db, version) async {
      await db.execute(query);
    });
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

  Future addPortfolio(String name) async {
    String date = DateTime.now().toString();
    try {
      await _database.insert(PortfolioTableName,
          Portfolio(name: name, createdAt: date, updatedAt: date).toJson());
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
