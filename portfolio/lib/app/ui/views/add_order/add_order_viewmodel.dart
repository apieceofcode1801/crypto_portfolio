import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AddOrderViewModel extends BaseViewModel {
  Coin _currentCoin;
  Coin get currentCoin => _currentCoin;

  final _databaseService = locator<DatabaseService>();

  int orderType;

  TextEditingController _coinController = TextEditingController();
  TextEditingController get coinController => _coinController;

  TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;
  TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  void setCurrentCoin(Coin coin) {
    _currentCoin = coin;
    _coinController.text = coin.name;
    notifyListeners();
  }

  Future addOrder(int portfolioId) async {
    setState(ViewState.Busy);
    final date = DateTime.now().toString();
    final order = Order(
        coinId: _currentCoin.id,
        coinSymbol: _currentCoin.symbol,
        type: orderType,
        amount: orderType == OrderType.buy
            ? num.parse(_amountController.text)
            : -num.parse(_amountController.text),
        price: num.parse(_priceController.text),
        portfolioId: portfolioId,
        date: date);
    await _databaseService.addOrder(order);
    setState(ViewState.Idle);
  }

  @override
  void onDispose() {
    _coinController.dispose();
    _amountController.dispose();
    _priceController.dispose();
  }
}
