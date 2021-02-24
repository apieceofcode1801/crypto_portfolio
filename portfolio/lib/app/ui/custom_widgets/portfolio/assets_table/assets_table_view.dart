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
        Divider(
          color: Colors.black,
        ),
        Expanded(
            child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
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
                    '${asset.amount}'.numberWithComma(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${asset.avgPrice}'.numberWithComma(),
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
                    '${asset.total}'.numberWithComma(),
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
}
