import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/assets_table/assets_table_viewmodel.dart';
import 'package:portfolio/app/ui/helpers/functions.dart';
import 'package:portfolio/app/ui/helpers/styles.dart';
import 'package:portfolio/core/base_view.dart';

class AssetTableView extends StatelessWidget {
  final Portfolio portfolio;
  final List<Asset> assets;
  const AssetTableView({@required this.portfolio, @required this.assets});
  @override
  Widget build(BuildContext context) {
    return BaseView<AssetsTableViewModel>(
      builder: (_, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          _titleRow(model),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (int i = 0; i < assets.length; i++)
                  Column(
                    children: [
                      Divider(
                        color: Colors.black,
                      ),
                      _assetRow(context, model.assets[i], i)
                    ],
                  )
              ],
            ),
          )),
        ],
      ),
      onModelReady: (model) => model.loadAssets(assets),
    );
  }

  Widget _titleRow(AssetsTableViewModel model) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              width: 44,
              child: Text(
                'No',
                style: Styles.tableTitle,
                textAlign: TextAlign.center,
              )),
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
              child: FlatButton(
            onPressed: model.sortByProfit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profit',
                  style: Styles.tableTitle,
                  textAlign: TextAlign.center,
                ),
                model.sortBy == SortBy.profitDown
                    ? Icon(
                        Icons.arrow_downward,
                        size: 15,
                      )
                    : model.sortBy == SortBy.profitUp
                        ? Icon(
                            Icons.arrow_upward,
                            size: 15,
                          )
                        : Container()
              ],
            ),
          )),
          Expanded(
              child: FlatButton(
            onPressed: model.sortByMarketTotal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total',
                  style: Styles.tableTitle,
                  textAlign: TextAlign.center,
                ),
                model.sortBy == SortBy.totalDown
                    ? Icon(
                        Icons.arrow_downward,
                        size: 15,
                      )
                    : model.sortBy == SortBy.totalUp
                        ? Icon(
                            Icons.arrow_upward,
                            size: 15,
                          )
                        : Container()
              ],
            ),
          )),
        ],
      );

  Widget _assetRow(BuildContext context, Asset asset, index) => GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 44,
                child: Text(
                  (index + 1).toString(),
                  textAlign: TextAlign.center,
                )),
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
          Navigator.pushNamed(context, Routes.asset,
              arguments: [portfolio.id, asset]);
        },
      );
}
