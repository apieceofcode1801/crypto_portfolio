import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class AddOrderViewModel extends BaseViewModel {
  Coin _currentCoin = Coin(id: 'bitcoin', name: 'Bitcoin', symbol: 'BTC');
  Coin get currentCoin => _currentCoin;

  TextEditingController _coinController = TextEditingController();
  TextEditingController get coinController => _coinController;

  void setCurrentCoin(Coin coin) {
    _currentCoin = coin;
    _coinController.text = coin.name;
    notifyListeners();
  }
}
