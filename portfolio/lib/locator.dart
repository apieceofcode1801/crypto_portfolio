import 'package:get_it/get_it.dart';
import 'package:portfolio/core/changenotifiers/portfolio_model.dart';
import 'package:portfolio/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/services/database_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => NavigationService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerLazySingleton(() => PortfolioModel());
}
