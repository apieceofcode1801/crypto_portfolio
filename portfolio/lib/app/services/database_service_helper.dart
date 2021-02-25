String createOrderTableQuery = '''
      CREATE TABLE orders(
    id INTEGER PRIMARY KEY,
    type INTEGER,
    coin_id TEXT,
    coin_symbol TEXT,
    date INTEGER,
    amount REAL,
    price REAL,
    portfolio_id INTEGER
);
''';
String createPortfolioTableQuery = '''
CREATE TABLE portfolios (
    id INTEGER PRIMARY KEY,
    name TEXT,
    created_at INTEGER,
    updated_at INTEGER
);
    ''';
