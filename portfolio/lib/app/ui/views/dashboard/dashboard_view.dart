import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_view.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('${model.btcPrice}'),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _reloadData(context, model);
                }),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.pushNamed(context, Routes.addPortfolio);
                  _reloadData(context, model);
                }),
          ],
        ),
        body: PageView.builder(
          onPageChanged: (index) {
            model.updateCurrentPortfolio(index);
          },
          itemBuilder: (context, index) {
            final portfolio = model.portfolios[index];
            return PortfolioView(
              portfolio: portfolio,
              btcPrice: model.btcPrice,
              onOpeningOrderList: () async {
                await Navigator.pushNamed(context, Routes.orderList,
                    arguments: portfolio);
                _reloadData(context, model);
              },
              onEditing: () async {
                await Navigator.pushNamed(context, Routes.addPortfolio,
                    arguments: portfolio);
                _reloadData(context, model);
              },
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: model.portfolios.length,
        ),
      ),
      onModelReady: (model) {
        _reloadData(context, model);
      },
    );
  }

  void _reloadData(context, model) async {
    await model.loadData();
    if (model.portfolios.isEmpty) {
      await Navigator.pushNamed(context, Routes.addPortfolio);
      model.loadData();
    }
  }
}
