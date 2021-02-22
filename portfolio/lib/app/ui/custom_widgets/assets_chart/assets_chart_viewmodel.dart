import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/custom_widgets/porfolio_asset/portfolio_asset_viewmodel.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class AssetsChartViewModel extends BaseViewModel {
  List<PieChartSectionData> loadSectionDatas({List<Asset> assets}) {
    List<PieChartSectionData> sectionDatas = [];
    final colors = assets.map((e) => UIHelpers.generateRandomColor()).toList();
    final total =
        assets.map((e) => e.total).reduce((value, element) => value + element);
    for (int i = 0; i < assets.length; i++) {
      final asset = assets[i];
      final percent = asset.total / total;
      final sectionData = PieChartSectionData(
          color: colors[i],
          value: percent,
          title: '${(percent * 100).toInt()}%',
          titleStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          radius: 50);
      sectionDatas.add(sectionData);
    }
    return sectionDatas;
  }
}