import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_title/portfolio_title_view.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

import 'assets_chart/assets_chart_view.dart';
import 'assets_table/assets_table_view.dart';

class PortfolioView extends StatelessWidget {
  final Function onOpenOrderList;
  final Function onEdit;
  final Portfolio portfolio;
  final num btcPrice;
  const PortfolioView(
      {@required this.portfolio,
      @required this.btcPrice,
      @required this.onOpenOrderList,
      @required this.onEdit});
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioViewModel>(
      builder: (context, model, child) => Stack(children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 150,
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
                        onPressed: onOpenOrderList,
                      ),
                      bottom: 8,
                      right: 8,
                    ),
                    Positioned(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: onEdit,
                      ),
                      top: 8,
                      right: 8,
                    )
                  ],
                ),
              ),
              model.assets.isNotEmpty
                  ? Expanded(
                      child: AssetsChartView(
                      assets: model.assets,
                    ))
                  : Container(),
              Expanded(child: AssetTableView(assets: model.assets)),
            ],
          ),
        ),
        model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container()
      ]),
      onModelReady: (model) {
        model.loadPortfolio(portfolio, btcPrice);
      },
      didUpdateWidget: (model) {
        model.loadPortfolio(portfolio, btcPrice);
      },
    );
  }
}
