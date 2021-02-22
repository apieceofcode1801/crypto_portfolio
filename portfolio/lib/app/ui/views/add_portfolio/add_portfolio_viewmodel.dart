import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AddPortfolioViewModel extends BaseViewModel {
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final _databaseService = locator<DatabaseService>();
  final _portfolioModel = locator<PortfolioModel>();

  Future<bool> addPortfolio() async {
    setState(ViewState.Busy);
    final date = DateTime.now().toString();
    final portfolio =
        Portfolio(name: _nameController.text, updatedAt: date, createdAt: date);
    final result = await _databaseService.addPortfolio(portfolio: portfolio);
    _portfolioModel.addPortfolio(portfolio);
    setState(ViewState.Idle);
    return result;
  }

  @override
  void onDispose() {
    _nameController.dispose();
    super.onDispose();
  }
}
