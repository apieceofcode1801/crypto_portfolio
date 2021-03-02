import 'dart:async';

import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/models/user_model.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/services/local_storage_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _apiService = locator<CoingeckoService>();
  final _userModel = locator<UserModel>();
  final _storageService = locator<LocalStorageService>();

  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  int _currentPortfolioIndex;
  Portfolio get currentPortfolio => _currentPortfolioIndex != null
      ? _portfolios[_currentPortfolioIndex]
      : null;

  double _btcPrice = 0;
  double get btcPrice => _btcPrice;

  Future loadData() async {
    _portfolios =
        await _dbService.getPortfolios(userId: _userModel.currentUser.id);
    if (_portfolios.isNotEmpty) {
      _currentPortfolioIndex = 0;
    } else {
      _currentPortfolioIndex = null;
    }
    _btcPrice = await _apiService.getPrice(CoinId.bitcoin);
    notifyListeners();
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
