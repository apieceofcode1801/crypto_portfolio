import 'dart:async';

import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/models/user_model.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/services/local_storage_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class DashboardViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _apiService = locator<CoingeckoService>();
  final _userModel = locator<UserModel>();
  final _storageService = locator<LocalStorageService>();

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

  List<Asset> get activeAssets =>
      _assets.where((element) => element.marketTotal > 1).toList();

  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  int _currentPortfolioIndex = 0;

  double get btcPrice => _btcPrice;

  Future loadData() async {
    setState(ViewState.Busy);
    _portfolios =
        await _dbService.getPortfolios(userId: _userModel.currentUser.id);
    if (portfolios.isEmpty) {
      return Future.value(null);
    }

    _btcPrice = await _apiService.getPrice(CoinId.bitcoin);
    final orders = await _dbService.getOrdersOfPortfolio(
        _portfolios[_currentPortfolioIndex].id.toString());
    final groupedOrders = orders.groupBy((e) => e.coinId);
    _prices = await _apiService
        .getPrices(groupedOrders.entries.map((e) => e.key).toList());

    _assets = groupedOrders.entries
        .map((e) => Asset(
            coinSymbol: e.value.map((e) => e.coinSymbol).toList().first,
            coinId: e.value.map((e) => e.coinId).toList().first,
            amount: e.value
                .map((e) => e.type == OrderType.buy ? e.amount : -e.amount)
                .reduce((value, element) => value + element),
            total: e.value
                .map((e) => e.type == OrderType.buy ? e.total : -e.total)
                .reduce((value, element) => value + element),
            curPrice: _prices[e.key] ?? 0))
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

  void loadPortfolio(Portfolio portfolio, num btcPrice) async {
    setState(ViewState.Busy);
    _btcPrice = btcPrice;

    setState(ViewState.Idle);
  }

  void refresh() {
    Timer.periodic(Duration(minutes: 15), (timer) async {
      loadData();
    });
  }

  void logout() {
    _storageService.save(key: LocalKeys.userId, value: null);
    _userModel.currentUser = null;
  }

  void updateCurrentPortfolio(int index) {
    _currentPortfolioIndex = index;
    notifyListeners();
  }
}
