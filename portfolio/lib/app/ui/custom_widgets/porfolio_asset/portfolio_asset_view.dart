import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/custom_widgets/assets_chart/assets_chart_view.dart';
import 'package:portfolio/app/ui/custom_widgets/center_loading_view.dart';
import 'package:portfolio/app/ui/custom_widgets/porfolio_asset/portfolio_asset_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class PortfolioAssetView extends StatelessWidget {
  final Portfolio portfolio;
  PortfolioAssetView({
    Key key,
    this.portfolio,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioAssetViewModel>(
      builder: (context, model, child) {
        return model.state == ViewState.Busy
            ? CenterLoadingView()
            : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    model.assets.isEmpty
                        ? Container()
                        : Container(
                            height:
                                2 * MediaQuery.of(context).size.width / 3 - 32,
                            child: AssetsChartView(
                              assets: model.assets,
                            ),
                          ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(child: AssetTableView(assets: model.assets))
                  ],
                ),
              );
      },
      onModelReady: (model) {
        model.loadAssets(portfolioId: portfolio.id);
      },
      didUpdateWidget: (model) {
        model.loadAssets(portfolioId: portfolio.id);
      },
    );
  }
}

class AssetTableView extends StatelessWidget {
  final List<Asset> assets;
  const AssetTableView({@required this.assets});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Text(
                'Coin',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'Amount',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'Avg. price',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            final asset = assets[index];
            return _assetRow(asset);
          },
          itemCount: assets.length,
        ))
      ],
    );
  }

  Widget _assetRow(Asset asset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Text(
          '${asset.coinSymbol}',
          textAlign: TextAlign.center,
        )),
        Expanded(
          child: Text(
            '${asset.amount}',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            '${asset.avgPrice}',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            '${asset.total}',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
