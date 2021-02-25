import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_title/portfolio_title_view.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_viewmodel.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

import 'assets_chart/assets_chart_view.dart';
import 'assets_table/assets_table_view.dart';

class PortfolioView extends StatelessWidget {
  final Function onOpeningOrderList;
  final Function onEditing;
  final Portfolio portfolio;
  final num btcPrice;
  const PortfolioView(
      {@required this.portfolio,
      @required this.btcPrice,
      @required this.onOpeningOrderList,
      @required this.onEditing});
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioViewModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 44.0),
              child: Stack(children: [
                Column(children: [
                  Container(
                    height: 120,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PortfolioTitleView(
                            title: portfolio.name,
                            total: model.total,
                            totalOnBtc: model.totalOnBtc,
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.list_alt),
                            onPressed: onOpeningOrderList,
                          ),
                          bottom: 8,
                          right: 8,
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: onEditing,
                          ),
                          top: 8,
                          right: 8,
                        ),
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
                                            assets: model.assets,
                                          ),
                                        ),
                                        title: 'Assets pie chart');
                                  },
                                ),
                                bottom: 8,
                                left: 8,
                              )
                      ],
                    ),
                  ),
                  model.assets.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: AssetTableView(assets: model.assets),
                        ))
                      : Container(),
                ]),
                model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
              ]),
            ),
      onModelReady: (model) {
        model.loadPortfolio(portfolio, btcPrice);
      },
      didUpdateWidget: (model) {
        model.loadPortfolio(portfolio, btcPrice);
      },
    );
  }
}
