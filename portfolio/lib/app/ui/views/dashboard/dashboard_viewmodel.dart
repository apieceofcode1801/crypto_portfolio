import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/api_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class DashboardViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _apiService = locator<ApiService>();
  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  Portfolio _currentPortfolio;
  Portfolio get currentPortfolio => _currentPortfolio;

  num _btcPrice = 0;
  num get btcPrice => _btcPrice;

  Future loadData() async {
    setState(ViewState.Busy);
    _portfolios = await _dbService.getPortfolios();
    if (_currentPortfolio == null && _portfolios.isNotEmpty) {
      _currentPortfolio = _portfolios.first;
    }
    _btcPrice = await _apiService.getPrice(CoinId.bitcoin);
    setState(ViewState.Idle);
  }

  void updateCurrentPortfolio(Portfolio portfolio) {
    _currentPortfolio = portfolio;
    notifyListeners();
  }
}
