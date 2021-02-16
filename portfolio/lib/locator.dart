import 'package:get_it/get_it.dart';
import 'package:portfolio/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/ui/views/startup/startup_viewmodel.dart';

import 'core/services/database_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerLazySingleton(() => DatabaseService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
}
