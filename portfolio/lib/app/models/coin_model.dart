import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class CoinModel extends BaseViewModel {
  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

  Future loadCoins() {}
}
