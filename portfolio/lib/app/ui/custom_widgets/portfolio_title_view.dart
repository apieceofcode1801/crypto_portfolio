import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';

class PortfolioTitleView extends StatelessWidget {
  final Portfolio portfolio;

  PortfolioTitleView({this.portfolio});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amberAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${portfolio.name}'),
            const SizedBox(
              height: 16,
            ),
            Text('\$50'),
            const SizedBox(
              height: 16,
            ),
            Text('0.001 BTC'),
          ],
        ));
  }
}
