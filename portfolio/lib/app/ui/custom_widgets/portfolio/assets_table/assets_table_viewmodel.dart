import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/core/base_viewmodel.dart';

enum SortBy { profitUp, profitDown, totalUp, totalDown }

class AssetsTableViewModel extends BaseViewModel {
  SortBy _sortBy = SortBy.totalDown;
  SortBy get sortBy => _sortBy;
  List<Asset> _assets = [];
  List<Asset> get assets => _assets;
  void sortByProfit() {
    switch (_sortBy) {
      case SortBy.profitDown:
        _sortBy = SortBy.profitUp;
        _assets.sortByProfit(true);
        break;
      case SortBy.profitUp:
        _sortBy = SortBy.profitDown;
        _assets.sortByProfit(false);
        break;
      default:
        _sortBy = SortBy.profitDown;
        _assets.sortByProfit(false);
        break;
    }

    notifyListeners();
  }

  void sortByMarketTotal() {
    switch (_sortBy) {
      case SortBy.totalDown:
        _sortBy = SortBy.totalUp;
        _assets.sortByMarketTotal(true);
        break;
      case SortBy.totalUp:
        _sortBy = SortBy.totalDown;
        _assets.sortByMarketTotal(false);
        break;
      default:
        _sortBy = SortBy.totalDown;
        _assets.sortByMarketTotal(false);
        break;
    }

    notifyListeners();
  }

  void loadAssets(List<Asset> assets) {
    _assets = assets;
  }
}

extension AssetListExtension on List<Asset> {
  void sortByProfit(bool asc) {
    this.sort((a, b) =>
        asc ? a.profit.compareTo(b.profit) : b.profit.compareTo(a.profit));
  }

  void sortByMarketTotal(bool asc) {
    this.sort((a, b) => asc
        ? a.marketTotal.compareTo(b.marketTotal)
        : b.marketTotal.compareTo(a.marketTotal));
  }
}
