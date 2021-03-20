import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/assets_chart/assets_chart_view.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/assets_table/assets_table_view.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_title/portfolio_title_view.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              model.logout();
              Navigator.pushReplacementNamed(context, Routes.auth);
            },
          ),
          title: Text('${model.btcPrice}'),
          actions: [
            model.state == ViewState.Busy
                ? Center(
                    child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 24,
                    height: 24,
                  ))
                : IconButton(
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
            return Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Stack(children: [
                Column(children: [
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PortfolioTitleView(
                            title: portfolio.name,
                            total: model.total,
                            marketTotal: model.marketTotal,
                            profit: model.profit,
                            totalOnBtc: model.totalOnBtc,
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.list_alt),
                            onPressed: () async {
                              await Navigator.pushNamed(
                                  context, Routes.orderList,
                                  arguments: [portfolio]);
                              _reloadData(context, model);
                            },
                          ),
                          bottom: 0,
                          right: 0,
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
                          top: 0,
                          right: 0,
                        ),
                        //Temporary remove for fixing web error
                        model.assets.isEmpty
                            ? Container()
                            : Positioned(
                                child: IconButton(
                                  icon: Icon(Icons.pie_chart),
                                  onPressed: () {
                                    showWidgetDialog(
                                        context: context,
                                        child: SingleChildScrollView(
                                          child: AssetsChartView(
                                              assets: model.activeAssets),
                                        ),
                                        title: 'Assets pie chart');
                                  },
                                ),
                                bottom: 0,
                                left: 0,
                              )
                      ],
                    ),
                  ),
                  model.assets.isNotEmpty
                      ? Expanded(
                          child: AssetTableView(
                            assets: model.activeAssets,
                            onEditAsset: (index) async {
                              await Navigator.pushNamed(context, Routes.asset,
                                  arguments: [
                                    portfolio.id,
                                    model.activeAssets[index]
                                  ]);
                              model.loadData();
                            },
                          ),
                        )
                      : Container(),
                ]),
              ]),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: model.portfolios.length,
        ),
      ),
      onModelReady: (model) async {
        await _reloadData(context, model);
        model.refresh();
      },
    );
  }

  Future _reloadData(context, model) async {
    await model.loadData();
    if (model.portfolios.isEmpty) {
      await Navigator.pushNamed(context, Routes.addPortfolio);
      model.loadData();
    }
  }
}
