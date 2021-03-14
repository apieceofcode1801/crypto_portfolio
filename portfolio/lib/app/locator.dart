import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/app/models/user_model.dart';
import 'package:portfolio/app/services/apis/firestore_api.dart';
import 'package:portfolio/app/services/apis/sqlite_api.dart';
import 'package:portfolio/app/services/authentication_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/services/local_storage_service.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/assets_chart/assets_chart_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_viewmodel.dart';
import 'package:portfolio/app/services/coingecko_service.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_viewmodel.dart';
import 'package:portfolio/app/ui/views/asset/asset_viewmodel.dart';
import 'package:portfolio/app/ui/views/auth/auth_viewmodel.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/app/ui/views/edit_order/edit_order_viewmodel.dart';
import 'package:portfolio/app/ui/views/order_list/order_list_viewmodel.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services
  locator.registerLazySingleton(() => kIsWeb
      ? DatabaseService(api: FirestoreApi())
      : DatabaseService(api: SqliteApi()));
  locator.registerLazySingleton(() => CoingeckoService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LocalStorageService());

  // viewmodels
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerFactory(() => EditOrderViewModel());
  locator.registerFactory(() => CoinListViewModel());
  locator.registerFactory(() => OrderListViewModel());
  locator.registerFactory(() => AddPortfolioViewModel());
  locator.registerFactory(() => AssetsChartViewModel());
  locator.registerFactory(() => PortfolioViewModel());
  locator.registerFactory(() => AuthViewModel());
  locator.registerFactory(() => AssetViewModel());

  locator.registerLazySingleton(() => UserModel());
}
