import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/datamodels/order.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/app/ui/views/edit_order/edit_order_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class EditOrderView extends StatelessWidget {
  final int portfolioId;
  final Order order;
  EditOrderView({Key key, this.portfolioId, this.order}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<EditOrderViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: order == null
              ? Text('Add your new order')
              : Text('Edit your order'),
          actions: order == null
              ? []
              : [
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        showAlertDialog(
                            context: context,
                            title: 'Confirmation',
                            content:
                                'Are you sure you want to delete this order?',
                            onContinue: () async {
                              await model.deleteOrder();
                              Navigator.pop(context);
                            });
                      })
                ],
        ),
        body: model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: model.dateController,
                      readOnly: true,
                      decoration: InputDecoration(hintText: 'Select date'),
                      onTap: () async {
                        DateTime selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 3650)),
                            lastDate: DateTime.now());
                        if (selectedDate != null) {
                          model.setSelectedDate(selectedDate);
                        }
                      },
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(hintText: 'Select coin'),
                      onTap: () async {
                        Coin coin = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CoinListView()));
                        if (coin != null) {
                          model.setCurrentCoin(coin);
                        }
                      },
                      validator: (value) =>
                          value.isEmpty ? 'Please select a coin' : null,
                      controller: model.coinController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButtonFormField(
                      value: model.orderType,
                      items: [
                        DropdownMenuItem(
                          child: Text('Buy'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('Sell'),
                          value: 1,
                        )
                      ],
                      onChanged: (value) {
                        model.orderType = value;
                      },
                      decoration: InputDecoration(hintText: 'Buy/Sell'),
                      validator: (value) =>
                          value == null ? 'Invalid order type' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter price'),
                      validator: (value) =>
                          value.isEmpty ? 'Invalid price' : null,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: model.priceController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter amount'),
                      validator: (value) =>
                          value.isEmpty ? 'Invalid amount' : null,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: model.amountController,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await model.submitOrder();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit'))
                  ],
                ),
              ),
      ),
      onModelReady: (model) {
        if (order != null) {
          model.setOrder(order);
        } else {
          model.setPortfolioId(portfolioId);
        }
      },
    );
  }
}
