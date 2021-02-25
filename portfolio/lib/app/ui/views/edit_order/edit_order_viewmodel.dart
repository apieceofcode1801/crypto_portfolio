import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class EditOrderViewModel extends BaseViewModel {
  int _portfolioId;
  int get portfolioId => _portfolioId;

  Coin _currentCoin;
  Coin get currentCoin => _currentCoin;

  Order _order;

  final _databaseService = locator<DatabaseService>();

  int orderType;

  TextEditingController _dateController = TextEditingController();
  TextEditingController get dateController => _dateController;

  TextEditingController _coinController = TextEditingController();
  TextEditingController get coinController => _coinController;

  TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;
  TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  void setOrder(Order order) {
    if (order != null) {
      _order = order;
      _dateController.text = order.date;
      _coinController.text = order.coinSymbol;
      _amountController.text = '${order.amount}';
      _priceController.text = '${order.price}';
      orderType = order.type;
      notifyListeners();
    }
  }

  void setPortfolioId(int id) {
    _portfolioId = id;
  }

  void setCurrentCoin(Coin coin) {
    _currentCoin = coin;
    _coinController.text = coin.name;
    notifyListeners();
  }

  Future submitOrder() async {
    setState(ViewState.Busy);
    final date = _dateController.text;
    if (_order == null) {
      final order = Order(
          coinId: _currentCoin.id,
          coinSymbol: _currentCoin.symbol,
          type: orderType,
          amount: orderType == OrderType.buy
              ? double.parse(_amountController.text)
              : -double.parse(_amountController.text),
          price: double.parse(_priceController.text),
          portfolioId: portfolioId,
          date: date);
      await _databaseService.addOrder(order);
    } else {
      await _databaseService.updateOrder(
          id: _order.id,
          order: _order.copy(
              coinId: _currentCoin?.id,
              coinSymbol: _currentCoin?.symbol,
              type: orderType,
              amount: orderType == OrderType.buy
                  ? double.parse(_amountController.text)
                  : -double.parse(_amountController.text),
              price: double.parse(_priceController.text),
              date: date));
    }
    setState(ViewState.Idle);
  }

  Future deleteOrder() async {
    setState(ViewState.Busy);
    await _databaseService.deleteOrder(id: _order.id);
    setState(ViewState.Idle);
  }

  void setSelectedDate(DateTime date) {
    _dateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY).format(date);
    notifyListeners();
  }

  @override
  void onDispose() {
    _dateController.dispose();
    _coinController.dispose();
    _amountController.dispose();
    _priceController.dispose();
  }
}
