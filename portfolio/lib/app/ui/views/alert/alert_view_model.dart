import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/alert.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AlertViewModel extends BaseViewModel {
  List<Alert> _alerts = [];
  List<Alert> get alerts => _alerts;

  final _labelController = TextEditingController();
  TextEditingController get labelController => _labelController;
  final _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;
  final _formKey = GlobalKey<FormState>();
  Key get formKey => _formKey;

  final _dbService = locator<DatabaseService>();

  Future getAlerts({String portfolioId, String coinId}) async {
    setState(ViewState.Busy);
    _alerts = await _dbService.getAlertsForAsset(portfolioId, coinId: coinId);
    setState(ViewState.Idle);
  }

  Future addAlert(String portfolioId, String coinId) async {
    setState(ViewState.Busy);
    final alert = Alert(
        portfolioId: portfolioId,
        coinId: coinId,
        label: _labelController.text,
        price: double.parse(_priceController.text));
    await _dbService.addAlert(alert);
    setState(ViewState.Idle);
  }

  Future editAlert({int index}) async {
    setState(ViewState.Busy);
    final alert = alerts[index].copy(
        label: _labelController.text,
        price: double.parse(_priceController.text));
    await _dbService.updateAlert(alert);
    setState(ViewState.Idle);
  }

  void resetController() {
    _labelController.text = '';
    _priceController.text = '';
  }

  @override
  void onDispose() {
    _labelController.dispose();
    _priceController.dispose();
    super.onDispose();
  }
}
