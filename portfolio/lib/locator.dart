import 'package:get_it/get_it.dart';
import 'package:portfolio/app/models/order_model.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_viewmodel.dart';
import 'package:portfolio/app/ui/services/api_service.dart';
import 'package:portfolio/app/ui/services/database_service.dart';
import 'package:portfolio/app/ui/views/add_order/add_order_viewmodel.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
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
  locator.registerLazySingleton(() => OrderModel());
  locator.registerFactory(() => AddOrderViewModel());
  locator.registerFactory(() => CoinListViewModel());
}
