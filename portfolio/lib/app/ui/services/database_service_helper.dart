String createPortfolioTableQuery = '''
      CREATE TABLE orders(
    id INTEGER PRIMARY KEY,
    type INTEGER,
    coin_id TEXT,
    date INTEGER,
    amount REAL,
    price REAL
);
''';
String createOrderTableQuery = '''
CREATE TABLE portfolios (
    id INTEGER PRIMARY KEY,
    name TEXT,
    created_at INTEGER,
    updated_at INTEGER
);
    ''';

String createOrderPortfolioRelationQuery = '''
CREATE TABLE order_portfolio(
  id INTEGER PRIMARY KEY,
  order_id INTEGER,
  portfolio_id INTEGER
);
''';
