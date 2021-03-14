import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/ui/helpers/functions.dart';
import 'package:portfolio/app/ui/helpers/styles.dart';
import 'package:portfolio/app/ui/views/asset/asset_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AssetView extends StatelessWidget {
  final String portfolioId;
  final Asset asset;
  AssetView(this.portfolioId, {this.asset});
  @override
  Widget build(BuildContext context) {
    return BaseView<AssetViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(asset.coinSymbol.toUpperCase()),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      await Navigator.pushNamed(context, Routes.updateOrder,
                          arguments: [portfolioId, asset]);
                      model.loadOrders();
                    })
              ],
            ),
            body: model.state == ViewState.Busy || model.asset == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      AssetTitleView(
                        asset: model.asset,
                      ),
                      Container(
                          height: 44,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('Date',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text('Type',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text('Price',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text('Amount',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text('Total',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 1,
                              ),
                            ],
                          )),
                      Divider(
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black,
                          ),
                          itemBuilder: (context, index) {
                            final order = model.orders[index];
                            return GestureDetector(
                              child: AssetOrderListItemView(
                                order: order,
                              ),
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, Routes.updateOrder,
                                    arguments: [order, model.asset]);
                                model.loadOrders();
                              },
                            );
                          },
                          itemCount: model.orders.length,
                        ),
                      )
                    ],
                  ));
      },
      onModelReady: (model) {
        model.set(portfolioId: portfolioId, asset: asset);
        model.loadOrders();
      },
    );
  }
}

class AssetOrderListItemView extends StatelessWidget {
  final Order order;
  AssetOrderListItemView({this.order});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${order.date}',
            textAlign: TextAlign.center,
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            '${order.type == OrderType.buy ? 'Buy' : 'Sell'}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: order.type == OrderType.buy ? Colors.blue : Colors.red),
          ),
          flex: 1,
        ),
        Expanded(
          child:
              Text('${formatNumber(order.price)}', textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${formatNumber(order.amount)}',
              textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${formatNumber(order.price * order.amount)}',
              textAlign: TextAlign.center),
          flex: 1,
        ),
      ],
    );
  }
}

class AssetTitleView extends StatelessWidget {
  final Asset asset;
  const AssetTitleView({this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.amberAccent,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Avg. price: ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text('\$' + asset.avgPrice.toStringAsFixed(3)),
          ]),
          const SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Market price: ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text('\$' + asset.curPrice.toString()),
          ]),
          const SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Total: ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text('\$' + asset.total.toStringAsFixed(2)),
          ]),
          const SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Market total: ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$' + asset.marketTotal.toStringAsFixed(2),
            ),
            Text(
              ' (${(asset.profit * 100).toStringAsFixed(2)}%)',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: asset.profit > 0 ? Colors.blue : Colors.red),
            ),
          ]),
        ],
      ),
    );
  }
}
