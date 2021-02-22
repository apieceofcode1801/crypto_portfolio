import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class PortfolioModel extends BaseViewModel {
  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  void setPortfolios(List<Portfolio> portfolios) {
    _portfolios = portfolios;
    notifyListeners();
  }

  void addPortfolio(Portfolio portfolio) {
    _portfolios.add(portfolio);
    notifyListeners();
  }

  void deletePortfolio(Portfolio portfolio) {
    _portfolios.remove(portfolio);
    notifyListeners();
  }

  // DatabaseService _dbService = locator<DatabaseService>();

  // Future loadPortfolios() async {
  //   setState(ViewState.Busy);
  //   _portfolios = await _dbService.getPortfolios();
  //   setState(ViewState.Idle);
  // }

  // Future<bool> addPortfolio(String name) async {
  //   setState(ViewState.Busy);
  //   final date = DateTime.now().toString();
  //   final portfolio = Portfolio(name: name, createdAt: date, updatedAt: date);
  //   _portfolios.add(portfolio);
  //   setState(ViewState.Idle);
  //   await _dbService.addPortfolio(portfolio);
  //   return true;
  // }
}
