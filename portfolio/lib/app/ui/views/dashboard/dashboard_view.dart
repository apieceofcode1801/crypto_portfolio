import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/custom_widgets/porfolio_asset/portfolio_asset_view.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio_title/portfolio_title_view.dart';
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
          body: Container(
              child: Column(
            children: [
              SizedBox(
                  height: 150,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      model.updateCurrentPortfolio(index);
                    },
                    itemBuilder: (context, index) {
                      final portfolio = model.portfolios[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                              child: PortfolioTitleView(
                            portfolio: portfolio,
                            btcPrice: model.btcPrice,
                          )),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.list_alt),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, Routes.orderList,
                                    arguments: portfolio);
                                _reloadData(context, model);
                              },
                            ),
                            bottom: 8,
                            right: 8,
                          ),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, Routes.addPortfolio,
                                    arguments: portfolio);
                                _reloadData(context, model);
                              },
                            ),
                            top: 8,
                            right: 8,
                          )
                        ],
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: model.portfolios.length,
                  )),
              model.currentPortfolio != null
                  ? Expanded(
                      child: PortfolioAssetView(
                      portfolio: model.currentPortfolio,
                    ))
                  : Container(),
            ],
          ))),
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
