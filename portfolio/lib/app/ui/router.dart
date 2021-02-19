import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/views/add_order/add_order_view.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_view.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_view.dart';
import 'package:portfolio/app/ui/views/startup/startup_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case Routes.startup:
        return MaterialPageRoute(builder: (_) => StartupView());
      case Routes.addPortfolio:
        return MaterialPageRoute(builder: (_) => AddPortfolioView());
      case Routes.addOrder:
        return MaterialPageRoute(builder: (_) => AddOrderView());
      case Routes.coinList:
        return MaterialPageRoute(builder: (_) => CoinListView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
