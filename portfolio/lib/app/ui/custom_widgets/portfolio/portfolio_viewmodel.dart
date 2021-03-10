import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class PortfolioViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final _apiService = locator<CoingeckoService>();
  double _total = 0;
  double get total => _total;

  double _marketTotal = 0;
  double get marketTotal => _marketTotal;

  double _totalOnBtc = 0;
  double get totalOnBtc => _totalOnBtc;

  double _profit = 0;
  double get profit => _profit;

  double _btcPrice = 0;

  Map<String, num> _prices = {};
  Map<String, num> get prices => _prices;

  List<Asset> _assets = [];
  List<Asset> get assets => _assets;

  void loadPortfolio(Portfolio portfolio, num btcPrice) async {
    setState(ViewState.Busy);
    _btcPrice = btcPrice;
    final orders =
        await _databaseService.getOrdersOfPortfolio(portfolio.id.toString());
    final groupedOrders = orders.groupBy((e) => e.coinId);
    _prices = await _apiService
        .getPrices(groupedOrders.entries.map((e) => e.key).toList());

    _assets = groupedOrders.entries
        .map((e) => Asset(
            coinSymbol: e.value.map((e) => e.coinSymbol).toList().first,
            coinId: e.value.map((e) => e.coinId).toList().first,
            amount: e.value
                .map((e) => e.amount)
                .reduce((value, element) => value + element),
            total: e.value
                .map((e) => e.total)
                .reduce((value, element) => value + element),
            curPrice: _prices[e.key] ?? 0))
        .toList()
        .where((element) => element.marketTotal > 1)
        .toList()
          ..sort((a, b) => b.marketTotal.compareTo(a.marketTotal));
    _total = _assets.isEmpty
        ? 0
        : _assets
            .map((e) => e.total)
            .reduce((value, element) => value + element);
    _marketTotal = _assets.isEmpty
        ? 0
        : _assets
            .map((e) => e.marketTotal)
            .reduce((value, element) => value + element);
    _profit = _total != 0 ? ((_marketTotal / _total) - 1) * 100 : 0;
    _totalOnBtc = _btcPrice != 0 ? total / _btcPrice : 0;
    setState(ViewState.Idle);
  }
}

class Asset {
  String coinId;
  String coinSymbol;
  double amount;
  double total;
  double curPrice;

  double get avgPrice => total / amount;
  double get marketTotal => amount * curPrice;
  double get profit => (curPrice - avgPrice) / avgPrice;

  Asset({this.coinSymbol, this.coinId, this.amount, this.total, this.curPrice});
}
