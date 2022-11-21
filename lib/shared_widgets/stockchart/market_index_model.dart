import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';


class ChartRange {
  double minX, minY, maxX, maxY;

  ChartRange(
      {this.minX = double.infinity,
        this.minY = double.infinity,
        this.maxX = 0.0,
        this.maxY = 0.0});
}

class MarketIndexModel {
  final String? symbol;
  final double? point;
  final double? change;
  final double? ratioChange;
  final double? tradingValue;
  final double? tradingVolume;
  final double? refPrice;
  final List<IndexChartInfoModel>? charts;

  MarketIndexModel({this.symbol, this.point, this.change, this.ratioChange, this.tradingValue, this.tradingVolume, this.refPrice, this.charts}){
    handlerData();
  }


  RxList<FlSpot> flSpots = <FlSpot>[].obs;
  Rx<ChartRange> chartRange = ChartRange().obs;
  late List<IndexChartInfoModel> filterData = [];

  void handlerData() {
    int ratio = 1;
    final splot = <FlSpot>[];
    final range = ChartRange();
    if (charts != null && charts!.isNotEmpty) {
      charts!.sort((a, b) => a.time.compareTo(b.time));
      filterData = charts!;
      if (charts!.length > 576) {
        ratio = (charts!.length / 288).floor();
      }
      for (int i = 0; i < filterData.length; i+= ratio) {
        final gd = filterData[i];
        if (gd.lowPrice > range.maxY) range.maxY = gd.lowPrice;
        if (gd.lowPrice <= range.minY) range.minY = gd.lowPrice;
        splot.add(FlSpot(i.toDouble(), gd.lowPrice));
      }
      if (range.minY == range.maxY) {
        if (splot.isEmpty) {
          splot.add(FlSpot(0.0, range.maxY));
          splot.add(FlSpot(1.0, range.maxY));
        } else if (splot.length == 1) {
          splot.add(FlSpot(1, range.maxY));
        }

        range.minY -= 1;
        range.maxY += 1;
      }
    } else {
      //print("Case null data");
      ///Case null data
      ///
      // for(double i=0;i<100;i++){
      //   splot.add(FlSpot(i, 1));
      // }
      splot.add(FlSpot(0, 1));
      splot.add(FlSpot(1, 1));

      range.maxY = 2;
      range.minY = 0;

    }
    range.minX = 0.0;
    range.maxX = splot.length.toDouble() - 1;
    chartRange.value = range;
    flSpots.clear();
    flSpots.addAll(splot);
    //print("flSpots.length ${flSpots.length}");
  }

  Color getColor(){
    if (change == 0) {
      return refColor;
    }
    if (change! > 0) {
      return increaseColor;
    }
    return decreaseColor;
  }

}

//Stock color state
const refColor = Color(0xFFFFBE40);
const ceilColor = Color(0xFFA500A8);
const floorColor = Color(0xFF2F80ED);
const increaseColor = Color(0xFF00B14F);
const decreaseColor = Color(0xFFF46666);
const drawColor = Color(0xFF333333);


class IndexChartInfoModel {
  final double lowPrice;
  final double time;

  IndexChartInfoModel({
    required this.lowPrice,
    required this.time,
  });
}