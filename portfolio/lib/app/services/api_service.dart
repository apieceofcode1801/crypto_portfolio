import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/core/base_network_adapter.dart';

abstract class ApiServiceAbstract {
  Future<List<Coin>> getListCoins();
  Future<num> getPrice(String coinId);
}

class ApiService implements ApiServiceAbstract {
  final baseURL = 'https://api.coingecko.com/api/v3/';
  @override
  Future<List<Coin>> getListCoins() async {
    final api = BaseNetworkAdapter(baseURL: baseURL);
    api.basePath = 'coins/list';
    api.parameters = {'include_platform': false};
    Iterable result = await api.request();
    return List<Coin>.from(result.map((e) => Coin.fromJson(e)));
  }

  @override
  Future<num> getPrice(String coinId) async {
    final api = BaseNetworkAdapter(baseURL: baseURL);
    api.basePath = 'simple/price';
    api.parameters = {'ids': coinId, 'vs_currencies': 'usd'};
    Map<String, dynamic> result = await api.request();
    return result[coinId]['usd'];
  }
}
