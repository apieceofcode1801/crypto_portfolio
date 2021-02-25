import 'package:flutter/material.dart';
import 'package:portfolio/app/extensions/extensions.dart';
import 'package:portfolio/app/ui/helpers/styles.dart';

import '../portfolio_viewmodel.dart';

class AssetTableView extends StatelessWidget {
  final List<Asset> assets;
  const AssetTableView({@required this.assets});
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
                  _assetRow(assets[i])
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

  Widget _assetRow(Asset asset) => Row(
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
              '${asset.amount.toStringAsFixed(2)}'.numberWithComma(),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '${asset.avgPrice.toStringAsFixed(2)}'.numberWithComma(),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '${asset.curPrice}'.numberWithComma(),
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
              '${asset.total.toStringAsFixed(2)}'.numberWithComma(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
