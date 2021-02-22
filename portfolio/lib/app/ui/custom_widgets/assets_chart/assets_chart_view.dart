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
              Expanded(
                  child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(PieChartData(
                  sections: model.loadSectionDatas(assets: assets),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                )),
              ))
            ],
          ),
        );
      },
    );
  }
}
