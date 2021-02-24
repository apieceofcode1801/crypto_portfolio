import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioTitleView extends StatelessWidget {
  final String title;
  final double total;
  final double totalOnBtc;

  PortfolioTitleView(
      {@required this.title, @required this.total, @required this.totalOnBtc});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title'),
            const SizedBox(
              height: 16,
            ),
            Text('${total.toStringAsFixed(2)} \$'),
            const SizedBox(
              height: 16,
            ),
            Text('${totalOnBtc.toStringAsFixed(6)} BTC'),
          ],
        ));
  }
}
