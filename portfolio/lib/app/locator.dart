import 'package:get_it/get_it.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/assets_chart/assets_chart_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_viewmodel.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_viewmodel.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/app/ui/views/edit_order/edit_order_viewmodel.dart';
import 'package:portfolio/app/ui/views/order_list/order_list_viewmodel.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => CoingeckoService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerFactory(() => EditOrderViewModel());
  locator.registerFactory(() => CoinListViewModel());
  locator.registerFactory(() => OrderListViewModel());
  locator.registerFactory(() => AddPortfolioViewModel());
  locator.registerFactory(() => AssetsChartViewModel());
  locator.registerFactory(() => PortfolioViewModel());
}
