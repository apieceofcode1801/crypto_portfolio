import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/helpers/functions.dart';
import 'package:portfolio/app/ui/helpers/styles.dart';

import '../portfolio_viewmodel.dart';

class AssetTableView extends StatelessWidget {
  final Portfolio portfolio;
  final List<Asset> assets;
  const AssetTableView({@required this.portfolio, @required this.assets});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
        ),
        _titleRow,
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            for (int i = 0; i < assets.length; i++)
              Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  _assetRow(context, assets[i])
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget get _titleRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Text(
            'Coin',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Amount',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Avg. price',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Cur. price',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Profit',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Total',
            style: Styles.tableTitle,
            textAlign: TextAlign.center,
          )),
        ],
      );

  Widget _assetRow(BuildContext context, Asset asset) => GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Text(
              '${asset.coinSymbol}'.toUpperCase(),
              textAlign: TextAlign.center,
            )),
            Expanded(
              child: Text(
                '${formatNumber(asset.amount)}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${formatNumber(asset.avgPrice)}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${formatNumber(asset.curPrice)}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${(100 * asset.profit).toStringAsFixed(2)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: asset.profit > 0 ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Expanded(
              child: Text(
                '${formatNumber(asset.marketTotal)}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.orderList,
              arguments: [portfolio, asset.coinId]);
        },
      );
}
