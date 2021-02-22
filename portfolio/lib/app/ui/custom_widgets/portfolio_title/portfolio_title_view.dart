import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio_title/portfolio_title_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class PortfolioTitleView extends StatelessWidget {
  final Portfolio portfolio;
  final num btcPrice;

  PortfolioTitleView({@required this.portfolio, @required this.btcPrice});
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioTitleViewModel>(
      builder: (context, model, child) => Container(
          color: Colors.amberAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${model.title}'),
              const SizedBox(
                height: 16,
              ),
              Text('${model.total} \$'),
              const SizedBox(
                height: 16,
              ),
              Text('${model.total / btcPrice} BTC'),
            ],
          )),
      onModelReady: (model) {
        model.loadPortfolio(portfolio);
      },
    );
  }
}
