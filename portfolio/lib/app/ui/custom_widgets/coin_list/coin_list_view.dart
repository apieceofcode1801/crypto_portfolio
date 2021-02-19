import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

import 'coin_list_viewmodel.dart';
import 'package:flutter/material.dart';

class CoinListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<CoinListViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Select coin'),
          ),
          body: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter your coin'),
                      onChanged: (text) {
                        model.searchText(text);
                      },
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: model.coins.length,
                      itemBuilder: (context, index) {
                        final coin = model.coins[index];
                        return ListTile(
                          title: Text('${coin.name}'),
                          onTap: () {
                            Navigator.pop(context, coin);
                          },
                        );
                      },
                    ))
                  ],
                ),
        );
      },
      onModelReady: (model) {
        model.loadCoins();
      },
    );
  }
}
