import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class PortfolioAssetViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();

  List<Asset> _assets = [];

  List<Asset> get assets => _assets;

  Future loadAssets({@required int portfolioId}) async {
    setState(ViewState.Busy);
    List<Order> orders =
        await _databaseService.getOrdersOfPortfolio(portfolioId);
    _assets = orders
        .groupBy((e) => e.coinId)
        .entries
        .map((e) => Asset(
            coinId: e.key,
            coinSymbol: e.value.map((e) => e.coinSymbol).toList().first,
            orders: e.value))
        .toList();
    setState(ViewState.Idle);
  }
}

class Asset {
  String coinId;
  String coinSymbol;
  List<Order> orders;

  num get amount =>
      orders.map((e) => e.amount).reduce((value, element) => value + element);
  num get total =>
      orders.map((e) => e.total).reduce((value, element) => value + element);

  num get avgPrice => total / amount;

  Asset({this.coinId, this.coinSymbol, this.orders});
}
