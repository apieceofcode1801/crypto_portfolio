import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AddPortfolioViewModel extends BaseViewModel {
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  Portfolio _portfolio;

  final _databaseService = locator<DatabaseService>();

  Future submitPortfolio() async {
    setState(ViewState.Busy);
    final date = DateTime.now().toString();
    if (_portfolio == null) {
      final portfolio = Portfolio(
          name: _nameController.text, updatedAt: date, createdAt: date);
      await _databaseService.addPortfolio(portfolio: portfolio);
    } else {
      final portfolio = _portfolio.copy(
          name: _nameController.text, updatedAt: DateTime.now().toString());
      await _databaseService.updatePortfolio(
          _portfolio.id.toString(), portfolio);
    }
    setState(ViewState.Idle);
  }

  Future deletePortfolio() async {
    setState(ViewState.Busy);
    await _databaseService.deletePortfolio(_portfolio.id.toString());
    setState(ViewState.Idle);
  }

  void setPortfolio(Portfolio portfolio) {
    if (portfolio != null) {
      _portfolio = portfolio;
      _nameController.text = portfolio.name;
    }
  }

  @override
  void onDispose() {
    _nameController.dispose();
    super.onDispose();
  }
}
