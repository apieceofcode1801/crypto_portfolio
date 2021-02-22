import 'package:get_it/get_it.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/porfolio_asset/portfolio_asset_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio_title/portfolio_title_viewmodel.dart';
import 'package:portfolio/app/services/api_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/ui/views/add_order/add_order_viewmodel.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_viewmodel.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/app/ui/views/order_list/order_list_viewmodel.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerSingleton<DatabaseService>(DatabaseService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerSingleton<PortfolioModel>(PortfolioModel());
  locator.registerFactory(() => AddOrderViewModel());
  locator.registerFactory(() => CoinListViewModel());
  locator.registerFactory(() => OrderListViewModel());
  locator.registerFactory(() => PortfolioTitleViewModel());
  locator.registerFactory(() => AddPortfolioViewModel());
  locator.registerFactory(() => PortfolioAssetViewModel());
}
