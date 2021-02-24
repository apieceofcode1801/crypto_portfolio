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
  Future<double> getPrice(String coinId) async {
    final api = BaseNetworkAdapter(baseURL: baseURL);
    api.basePath = 'simple/price';
    api.parameters = {'ids': coinId, 'vs_currencies': 'usd'};
    Map<String, dynamic> result = await api.request();
    return double.parse(result[coinId]['usd'].toString());
  }

  Future<Map<String, num>> getPrices(List<String> coinIds) async {
    final api = BaseNetworkAdapter(baseURL: baseURL);
    api.basePath = 'simple/price';
    api.parameters = {'ids': coinIds.join(','), 'vs_currencies': 'usd'};
    Map<String, dynamic> result = await api.request();
    return Map.fromEntries(result.entries
        .map((e) => MapEntry(e.key, double.parse(e.value['usd'].toString()))));
  }
}
