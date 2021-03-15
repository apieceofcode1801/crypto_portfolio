import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/views/asset/asset_view.dart';
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
          final args = settings.arguments as List;
          String portfolioId;
          Order order;
          Asset asset;
          if (args.first is String) {
            portfolioId = args.first;
          } else if (args.first is Order) {
            order = args.first;
          }
          if (args.length == 2 && args.last is Asset) {
            asset = args.last;
          }
          return EditOrderView(
              portfolioId: portfolioId, order: order, asset: asset);
        });
      case Routes.coinList:
        return MaterialPageRoute(builder: (_) => CoinListView());
      case Routes.orderList:
        return MaterialPageRoute(builder: (_) {
          final arguments = settings.arguments as List;
          final portfolio = arguments.first;
          return OrderListView(portfolio: portfolio);
        });
      case Routes.asset:
        return MaterialPageRoute(builder: (_) {
          final args = settings.arguments as List;
          return AssetView(
            args.first,
            asset: args.last,
          );
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
