import 'package:portfolio/core/datamodels/porfolio.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/core/services/database_service.dart';
import 'package:portfolio/locator.dart';
import 'package:portfolio/ui/views/base/base_viewmodel.dart';

class PortfolioModel extends BaseViewModel {
  List<Portfolio> _portfolios = [];
  List<Portfolio> get portfolios => _portfolios;

  DatabaseService _dbService = locator<DatabaseService>();

  Future loadPortfolios() async {
    setState(ViewState.Busy);
    _portfolios = await _dbService.getPortfolios();
    setState(ViewState.Idle);
  }

  Future<bool> addPortfolio(String name) async {
    setState(ViewState.Busy);
    final date = DateTime.now().toString();
    final portfolio = Portfolio(name: name, createdAt: date, updatedAt: date);
    _portfolios.add(portfolio);
    setState(ViewState.Idle);
    await _dbService.addPortfolio(portfolio);
    return true;
  }
}
