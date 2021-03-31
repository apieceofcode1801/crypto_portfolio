import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/locator.dart';

class CoinListViewModel extends BaseViewModel {
  List<Coin> _coins = [];
  String _searchedText = '';
  List<Coin> get coins {
    return _coins
        .where((e) =>
            e.name.containOnSearch(_searchedText) ||
            e.symbol.containOnSearch(_searchedText) ||
            e.id.containOnSearch(_searchedText))
        .toList();
  }

  CoingeckoService _apiService = locator<CoingeckoService>();

  void loadCoins() async {
    setState(ViewState.Busy);
    _coins = await _apiService.getListCoins();
    setState(ViewState.Idle);
  }

  void searchText(String text) {
    _searchedText = text;
    notifyListeners();
  }
}

extension StringSearch on String {
  bool containOnSearch(String text) {
    return toLowerCase().contains(text.toLowerCase());
  }
}
