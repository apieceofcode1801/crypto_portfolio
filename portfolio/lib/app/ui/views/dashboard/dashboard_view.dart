import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio_title_view.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Crypto portfolio'),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.addOrder);
                    })
              ],
            ),
            body: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: 200,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return PortfolioTitleView(
                          portfolio: model.portfolios[index],
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: model.portfolios.length,
                    )));
      },
      onModelReady: (model) async {
        await model.loadPortfolios();
        if (model.portfolios.isEmpty) {
          Navigator.pushNamed(context, Routes.addPortfolio);
        }
      },
    );
  }
}
