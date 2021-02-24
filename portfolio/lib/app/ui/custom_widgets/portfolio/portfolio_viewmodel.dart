import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/api_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class PortfolioViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final _apiService = locator<ApiService>();
  double _total = 0;
  double get total => _total;

  double _totalOnBtc = 0;
  double get totalOnBtc => _totalOnBtc;

  double _btcPrice = 0;

  Map<String, num> _prices = {};
  Map<String, num> get prices => _prices;

  List<Asset> _assets = [];
  List<Asset> get assets => _assets;

  void loadPortfolio(Portfolio portfolio, num btcPrice) async {
    setState(ViewState.Busy);
    _btcPrice = btcPrice;
    final orders = await _databaseService.getOrdersOfPortfolio(portfolio.id);
    final groupedOrders = orders.groupBy((e) => e.coinId);
    _prices = await _apiService
        .getPrices(groupedOrders.entries.map((e) => e.key).toList());

    _assets = groupedOrders.entries
        .map((e) => Asset(
            coinSymbol: e.value.map((e) => e.coinSymbol).toList().first,
            amount: e.value
                .map((e) => e.amount)
                .reduce((value, element) => value + element),
            total: e.value
                .map((e) => e.total)
                .reduce((value, element) => value + element),
            curPrice: _prices[e.key]))
        .toList();
    _total = _assets.isEmpty
        ? 0
        : _assets
            .map((e) => e.amount * e.curPrice)
            .reduce((value, element) => value + element);
    _totalOnBtc = _btcPrice != 0 ? total / _btcPrice : 0;
    setState(ViewState.Idle);
  }
}

class Asset {
  String coinSymbol;
  double amount;
  double total;
  double curPrice;

  double get avgPrice => total / amount;
  double get profit => (curPrice - avgPrice) / avgPrice;

  Asset({this.coinSymbol, this.amount, this.total, this.curPrice});
}
