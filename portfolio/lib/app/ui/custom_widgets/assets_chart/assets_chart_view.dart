import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/custom_widgets/assets_chart/assets_chart_viewmodel.dart';
import 'package:portfolio/app/ui/custom_widgets/porfolio_asset/portfolio_asset_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class AssetsChartView extends StatelessWidget {
  final List<Asset> assets;
  const AssetsChartView({this.assets});
  @override
  Widget build(BuildContext context) {
    return BaseView<AssetsChartViewModel>(
      builder: (context, model, child) {
        return Container(
            child: Column(
          children: [
            Wrap(
              runSpacing: 5,
              spacing: 5,
              children: [
                for (int i = 0; i < assets.length; i++)
                  Container(
                    child: Wrap(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: model.colors[i]),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${assets[i].coinSymbol}',
                          maxLines: 1,
                        )
                      ],
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(PieChartData(
                sections: model.sectionDatas,
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
              )),
            ))
          ],
        ));
      },
      onModelReady: (model) {
        model.loadData(assets);
      },
    );
  }
}
