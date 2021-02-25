import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/extensions/extensions.dart';

class PortfolioTitleView extends StatelessWidget {
  final String title;
  final double total;
  final double marketTotal;
  final double totalOnBtc;
  final double profit;

  PortfolioTitleView(
      {@required this.title,
      @required this.total,
      @required this.marketTotal,
      @required this.profit,
      @required this.totalOnBtc});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text('${total.toStringAsFixed(2).numberWithComma()} \$')
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Market total: ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text('${marketTotal.toStringAsFixed(2).numberWithComma()} \$ '),
                Text(
                  '(${profit.toStringAsFixed(2)} %)',
                  style:
                      TextStyle(color: profit > 0 ? Colors.blue : Colors.red),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text('${totalOnBtc.toStringAsFixed(6)} BTC'),
          ],
        ));
  }
}
