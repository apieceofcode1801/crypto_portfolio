import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/coin.dart';
import 'package:portfolio/app/ui/custom_widgets/coin_list/coin_list_view.dart';
import 'package:portfolio/app/ui/views/add_order/add_order_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AddOrderView extends StatelessWidget {
  final int portfolioId;
  AddOrderView({
    Key key,
    this.portfolioId,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AddOrderViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add your new order'),
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
                            await model.addOrder(portfolioId);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit'))
                  ],
                ),
              ),
      ),
    );
  }
}
