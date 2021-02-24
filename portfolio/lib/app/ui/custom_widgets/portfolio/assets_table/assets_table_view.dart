import 'package:flutter/material.dart';

import '../portfolio_viewmodel.dart';

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
          child: _titleRow,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            final asset = assets[index];
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
                    '${asset.curPrice}',
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
                    '${asset.total}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
          itemCount: assets.length,
        ))
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
            'Cur. price',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            'Profit',
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
      );
}
