import 'package:get_it/get_it.dart';
import 'package:portfolio/app/models/coin_model.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/app/ui/services/database_service.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerSingleton<DatabaseService>(DatabaseService());
  locator.registerLazySingleton(() => NavigationService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerSingleton<PortfolioModel>(PortfolioModel());
  locator.registerLazySingleton(() => CoinModel());
}
