import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AssetsChartViewModel extends BaseViewModel {
  List<ChartItem> _chartItems = [];
  List<ChartItem> get chartItems => _chartItems;

  List<PieChartSectionData> _sectionDatas = [];
  List<PieChartSectionData> get sectionDatas => _sectionDatas;

  void loadData([List<Asset> assets]) {
    setState(ViewState.Busy);
    _chartItems.clear();
    _sectionDatas.clear();
    final marketTotal = assets
        .map((e) => e.marketTotal)
        .reduce((value, element) => value + element);

    final bigAssets =
        assets.where((e) => e.marketTotal / marketTotal > 0.03).toList();
    final otherAssets =
        assets.where((e) => e.marketTotal / marketTotal <= 0.03).toList();
    _chartItems.addAll(bigAssets.map((e) => ChartItem(
        label: e.coinSymbol.toUpperCase(),
        percent: e.marketTotal / marketTotal,
        color: UIHelpers.generateRandomColor())));
    _chartItems.add(ChartItem(
        label: 'Others',
        percent: otherAssets
                .map((e) => e.total)
                .reduce((value, element) => value + element) /
            marketTotal,
        color: UIHelpers.generateRandomColor()));
    _sectionDatas.addAll(_chartItems.map((e) => PieChartSectionData(
        color: e.color,
        value: e.percent,
        title: e.label,
        titleStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        radius: 50)));
    setState(ViewState.Idle);
  }
}

class ChartItem {
  final String label;
  final double percent;
  final Color color;

  const ChartItem(
      {@required this.label, @required this.percent, @required this.color});
}
