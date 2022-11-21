import 'dart:ui';

import 'package:finews_module/shared_widgets/stockchart/stock_chart_model.dart';
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

class StockModel {
  String symbol;
  String stockName;
  String imageUrl;
  int stockType;
  double lastPrice;
  RxDouble lastPriceRealtime = 0.0.obs;
  double change;
  double ratioChange;
  RxDouble ratioChangeRealtime = 0.0.obs;
  RxDouble changeRealtime = 0.0.obs;
  double ceiling;
  double floor;
  double refPrice;
  bool isProductWatching;
  //
  // String get fullLink =>
  //     "${Environment().backendUrl}/resource/v1/stock-image/$imageUrl";

  RxList<FlSpot> flSpots = <FlSpot>[].obs;
  Rx<ChartRange> chartRange = ChartRange().obs;
  List<PriceChartInfoModel>? listGrowData;
  late List<PriceChartInfoModel> filterData = [];

  StockModel(
      {required this.symbol,
      required this.stockName,
      required this.imageUrl,
      required this.stockType,
      required this.lastPrice,
      required this.change,
      required this.ratioChange,
      required this.ceiling,
      required this.floor,
      required this.refPrice,
      required this.isProductWatching,});

  // StockModel({
  //   this.symbol,
  //   this.stockName,
  //   this.lastPrice,
  // });

  void handlerData(List<PriceChartInfoModel>? listGrowData) {
    final splot = <FlSpot>[];
    final range = ChartRange();
    this.listGrowData = listGrowData;
    if (listGrowData != null && listGrowData.isNotEmpty) {
      filterData = listGrowData;

      for (int i = 0; i < filterData.length; i++) {
        final gd = filterData[i];
        if (gd.price > range.maxY) range.maxY = gd.price;
        if (gd.price <= range.minY) range.minY = gd.price;
        splot.add(FlSpot(i.toDouble(), gd.price));
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
      ///Case null data
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

  Color getColor() {
    return lastPrice.getStockColorWith(refPrice, floor, ceiling);
  }

}


//Stock color state
const refColor = Color(0xFFFFBE40);
const ceilColor = Color(0xFFA500A8);
const floorColor = Color(0xFF2F80ED);
const increaseColor = Color(0xFF00B14F);
const decreaseColor = Color(0xFFF46666);
const drawColor = Color(0xFF333333);

extension CustomDoubleExtension on double {

  Color getStockColorWith(
      double ref,
      double floor,
      double ceil, {
        Color? colorDefault,
      }) {
    if (this == 0) return colorDefault ?? drawColor;
    if (this > ref && this < ceil) {
      return increaseColor;
    }

    if (this < ref && this > floor) {
      return decreaseColor;
    }

    if (this == floor) {
      return floorColor;
    }

    if (this == ceil) {
      return ceilColor;
    }

    return refColor;
  }

}