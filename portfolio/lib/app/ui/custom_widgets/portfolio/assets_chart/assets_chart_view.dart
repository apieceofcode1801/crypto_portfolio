import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/ui/helpers/responsive_view.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

import 'assets_chart_viewmodel.dart';

class AssetsChartView extends StatelessWidget {
  final List<Asset> assets;
  const AssetsChartView({this.assets});
  @override
  Widget build(BuildContext context) {
    return BaseView<AssetsChartViewModel>(
      builder: (context, model, child) {
        return model.state == ViewState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: model.chartItems
                          .map((e) => _assetTitleItemView(
                              '${e.label} (${(e.percent * 100).toStringAsFixed(2)}%)',
                              e.color))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    !ScreenSize.isSizeSmall(context)
                        ? Container(
                            width: 400,
                            height: 400,
                            child: _assetPieChart(model),
                          )
                        : _assetPieChart(model),
                  ],
                ));
      },
      onModelReady: (model) {
        model.loadData(assets);
      },
    );
  }

  Container _assetTitleItemView(String title, Color color) {
    return Container(
      child: Wrap(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: color),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget _assetPieChart(AssetsChartViewModel model) => AspectRatio(
        aspectRatio: 1,
        child: PieChart(PieChartData(
          sections: model.sectionDatas,
          borderData: FlBorderData(show: false),
          startDegreeOffset: 180,
          sectionsSpace: 1,
        )),
      );
}
