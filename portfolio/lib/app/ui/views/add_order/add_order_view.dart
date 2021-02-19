import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/models/order_model.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/views/add_order/add_order_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AddOrderView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<AddOrderViewModel>(
      builder: (context, addOrderModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add your new order'),
          ),
          body: BaseView<OrderModel>(
            builder: (context, orderModel, child) {
              return orderModel.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          TextFormField(
                            readOnly: true,
                            decoration:
                                InputDecoration(hintText: 'Select coin'),
                            onTap: () async {
                              Coin coin = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CoinListView(),
                                  ));
                              if (coin != null) {
                                addOrderModel.setCurrentCoin(coin);
                              }
                            },
                            validator: (value) =>
                                value.isEmpty ? 'Please select a coin' : null,
                            controller: addOrderModel.coinController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: 'Enter price'),
                            validator: (value) =>
                                value.isEmpty ? 'Invalid price' : null,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _priceController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: 'Enter amount'),
                            validator: (value) =>
                                value.isEmpty ? 'Invalid amount' : null,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _amountController,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (await orderModel.addOrder(
                                      coinId: addOrderModel.currentCoin.id,
                                      price:
                                          double.parse(_priceController.text),
                                      amount: double.parse(
                                          _amountController.text))) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text('Submit'))
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
