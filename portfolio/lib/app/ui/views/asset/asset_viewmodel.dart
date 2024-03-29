import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AssetViewModel extends BaseViewModel {
  Asset _asset;
  Asset get asset => _asset;
  String _portfolioId;
  List<Order> _orders;
  List<Order> get orders => _orders;
  final _dbService = locator<DatabaseService>();

  AssetViewModel({String portfolioId, Asset asset}) {
    _portfolioId = portfolioId;
    _asset = asset;
  }

  set({String portfolioId, Asset asset}) {
    _portfolioId = portfolioId;
    _asset = asset;
  }

  void loadOrders() async {
    setState(ViewState.Busy);
    _orders = await _dbService.getOrdersForAsset(
        portfolioId: _portfolioId, coinId: _asset.coinId);
    _orders.sortByDate();
    _asset = _asset.copy(
        amount: _orders
            .map((e) => e.type == OrderType.buy ? e.amount : -e.amount)
            .reduce((value, element) => value + element),
        total: _orders
            .map((e) => e.type == OrderType.buy ? e.total : -e.total)
            .reduce((value, element) => value + element));
    setState(ViewState.Idle);
  }
}
