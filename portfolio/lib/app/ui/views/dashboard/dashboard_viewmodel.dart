import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/api_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _apiService = locator<ApiService>();
  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  int _currentPortfolioIndex;
  Portfolio get currentPortfolio => _currentPortfolioIndex != null
      ? _portfolios[_currentPortfolioIndex]
      : null;

  num _btcPrice = 0;
  num get btcPrice => _btcPrice;

  Future loadData() async {
    _portfolios = await _dbService.getPortfolios();
    if (_portfolios.isNotEmpty) {
      _currentPortfolioIndex = 0;
    } else {
      _currentPortfolioIndex = null;
    }
    _btcPrice = await _apiService.getPrice(CoinId.bitcoin);
    notifyListeners();
  }

  void updateCurrentPortfolio(int index) {
    _currentPortfolioIndex = index;
    notifyListeners();
  }
}
