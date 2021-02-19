import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/core/base_network_adapter.dart';

abstract class ApiServiceAbstract {
  Future<List<Coin>> getListCoins();
}

class ApiService implements ApiServiceAbstract {
  @override
  Future<List<Coin>> getListCoins() async {
    final api = BaseNetworkAdapter();
    api.basePath = 'coins/list';
    api.parameters = {'include_platform': false};
    Iterable result = await api.request();
    return List<Coin>.from(result.map((e) => Coin.fromJson(e)));
  }
}
