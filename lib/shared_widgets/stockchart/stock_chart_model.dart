

class StockChartModel {
  final String? symbol;
  final List<PriceChartInfoModel>? charts;

  StockChartModel({this.symbol, this.charts});
}


class PriceChartInfoModel {
  final double price;
  final double time;

  PriceChartInfoModel({
    required this.price,
    required this.time,
  });
}