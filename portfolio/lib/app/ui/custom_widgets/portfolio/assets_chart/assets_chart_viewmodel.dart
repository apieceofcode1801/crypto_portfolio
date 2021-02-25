import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/custom_widgets/portfolio/portfolio_viewmodel.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AssetsChartViewModel extends BaseViewModel {
  List<Color> _colors = [];
  List<Color> get colors => _colors;

  List<PieChartSectionData> _sectionDatas = [];
  List<PieChartSectionData> get sectionDatas => _sectionDatas;

  void loadData([List<Asset> assets]) {
    setState(ViewState.Busy);
    _colors = assets.map((e) => UIHelpers.generateRandomColor()).toList();
    final marketTotal = assets
        .map((e) => e.marketTotal)
        .reduce((value, element) => value + element);
    _sectionDatas.clear();
    for (int i = 0; i < assets.length; i++) {
      final asset = assets[i];
      final percent = asset.marketTotal / marketTotal;
      final sectionData = PieChartSectionData(
          color: _colors[i],
          value: percent,
          title: '${(percent * 100).toInt()}%',
          titleStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          radius: 50);
      _sectionDatas.add(sectionData);
    }
    setState(ViewState.Idle);
  }
}
