import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/helpers/styles.dart';
import 'package:portfolio/app/ui/views/order_list/order_list_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class OrderListView extends StatelessWidget {
  final Portfolio portfolio;
  OrderListView({this.portfolio});
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderListViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('${portfolio.name}'),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      await Navigator.pushNamed(context, Routes.updateOrder,
                          arguments: portfolio.id);
                      model.loadOrders(portfolio.id.toString());
                    })
              ],
            ),
            body: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                          height: 44,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('Date',
                                    textAlign: TextAlign.center,
                                    style: Styles.tableTitle),
                                flex: 2,
                              ),
                              Expanded(
                                child: Text(
                                  'Coin',
                                  textAlign: TextAlign.center,
                                  style: Styles.tableTitle,
                                ),
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
                              child: OrderListItemView(
                                order: order,
                              ),
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, Routes.updateOrder,
                                    arguments: order);
                                model.loadOrders(portfolio.id.toString());
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
        model.loadOrders(portfolio.id.toString());
      },
    );
  }
}

class OrderListItemView extends StatelessWidget {
  final Order order;
  OrderListItemView({this.order});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${order.date}',
            textAlign: TextAlign.center,
          ),
          flex: 2,
        ),
        Expanded(
          child: Text('${order.coinSymbol}', textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${order.type == OrderType.buy ? 'Buy' : 'Sell'}',
              textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${order.price}'.numberWithComma(),
              textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${order.amount}'.numberWithComma(),
              textAlign: TextAlign.center),
          flex: 1,
        ),
        Expanded(
          child: Text('${order.price * order.amount}'.numberWithComma(),
              textAlign: TextAlign.center),
          flex: 1,
        ),
      ],
    );
  }
}
