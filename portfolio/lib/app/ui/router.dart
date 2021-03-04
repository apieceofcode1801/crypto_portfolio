import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/views/auth/auth_view.dart';
import 'package:portfolio/app/ui/views/edit_order/edit_order_view.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_view.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_view.dart';
import 'package:portfolio/app/ui/views/order_list/order_list_view.dart';
import 'package:portfolio/app/ui/views/startup/startup_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => AuthView());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case Routes.startup:
        return MaterialPageRoute(builder: (_) => StartupView());
      case Routes.addPortfolio:
        return MaterialPageRoute(
            builder: (_) => AddPortfolioView(
                  portfolio: settings.arguments,
                ));
      case Routes.updateOrder:
        return MaterialPageRoute(builder: (_) {
          if (settings.arguments is String) {
            final String portfolioId = settings.arguments;
            return EditOrderView(
              portfolioId: portfolioId,
            );
          } else {
            return EditOrderView(
              order: settings.arguments,
            );
          }
        });
      case Routes.coinList:
        return MaterialPageRoute(builder: (_) => CoinListView());
      case Routes.orderList:
        return MaterialPageRoute(builder: (_) {
          final arguments = settings.arguments as List;
          final portfolio = arguments.first;
          String coinId;
          if (arguments.length == 2) {
            coinId = arguments[1];
          }
          return OrderListView(portfolio: portfolio, coinId: coinId);
        });
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
