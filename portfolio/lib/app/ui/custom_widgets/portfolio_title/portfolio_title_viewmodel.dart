import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class PortfolioTitleViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();

  String _title = '';
  num _total = 0;

  String get title => _title;
  num get total => _total;

  void loadPortfolio(Portfolio portfolio) async {
    setState(ViewState.Busy);
    _title = portfolio.name;
    final orders = await _databaseService.getOrdersOfPortfolio(portfolio.id);
    _total = orders.isEmpty
        ? 0
        : orders
            .map((e) => e.total)
            .reduce((value, element) => value + element);
    setState(ViewState.Idle);
  }
}
