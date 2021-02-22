import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:portfolio/app/datamodels/porfolio.dart';
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
            : Column(
                children: [
                  _titleView,
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      final asset = model.assets[index];
                      return _assetRow(asset);
                    },
                    itemCount: model.assets.length,
                  )),
                ],
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

  final Widget _titleView = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(child: Text('Coin')),
      Expanded(child: Text('Amount')),
      Expanded(child: Text('Avg. price')),
      Expanded(child: Text('Total')),
    ],
  );

  Widget _assetRow(Asset asset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: Text('${asset.coinSymbol}')),
        Expanded(
          child: Text('${asset.amount}'),
        ),
        Expanded(
          child: Text('${asset.avgPrice}'),
        ),
        Expanded(
          child: Text('${asset.total}'),
        ),
      ],
    );
  }
}
