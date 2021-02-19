import 'package:flutter/material.dart';
import 'package:portfolio/core/consts/routes.dart';
import 'package:portfolio/ui/views/add_portfolio/add_portfolio_view.dart';
import 'package:portfolio/ui/views/dashboard/dashboard_view.dart';
import 'package:portfolio/ui/views/startup/startup_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case Routes.startup:
        return MaterialPageRoute(builder: (_) => StartupView());
      case Routes.addPortfolio:
        return MaterialPageRoute(builder: (_) => AddPortfolioView());
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
