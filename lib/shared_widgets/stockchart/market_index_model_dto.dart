import 'package:json_annotation/json_annotation.dart';

import 'market_index_model.dart';

part 'market_index_model_dto.g.dart';

@JsonSerializable()
class MarketIndexModelDTO {
  @JsonKey(name: "symbol")
  final String? symbol;
  @JsonKey(name: "point")
  final double? point;
  @JsonKey(name: "change")
  final double? change;
  @JsonKey(name: "ratioChange")
  final double? ratioChange;
  @JsonKey(name: "tradingValue")
  final double? tradingValue;
  @JsonKey(name: "tradingVolume")
  final double? tradingVolume;
  @JsonKey(name: "refPrice")
  final double? refPrice;
  @JsonKey(name: "charts")
  final List<IndexChartInfoModelDTO>? charts;

  MarketIndexModelDTO(this.symbol, this.point, this.change, this.ratioChange, this.tradingValue, this.tradingVolume, this.refPrice, this.charts);

  static Future<MarketIndexModelDTO> fromResult(dynamic data) async =>
      MarketIndexModelDTO.fromJson(data as Map<String, dynamic>);

  factory MarketIndexModelDTO.fromJson(dynamic json) =>
      _$MarketIndexModelDTOFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$MarketIndexModelDTOToJson(this);

  static List<MarketIndexModelDTO> getList(dynamic data) {
    final list = data as List;
    return list
        .map((e) => MarketIndexModelDTO.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  List<IndexChartInfoModel> getListProductWatching() {
    final items = <IndexChartInfoModel>[];
    if (charts != null) {
      for (final item in charts!) {
        items.add(item.toModel());
      }
    }
    return items;
  }
}

extension MarketIndexModelMapper on MarketIndexModelDTO {
  MarketIndexModel toModel() {
    return MarketIndexModel(
      symbol: symbol,
      point: point ?? 0,
      change: change ?? 0,
      ratioChange: ratioChange ?? 0,
      tradingValue: tradingValue ?? 0,
      tradingVolume: tradingVolume ?? 0,
      refPrice: refPrice ?? 0,
      charts: getListProductWatching(),
    );
  }
}

@JsonSerializable()
class IndexChartInfoModelDTO {
  @JsonKey(name: "lowPrice")
  final double? lowPrice;
  @JsonKey(name: "time")
  final double? time;

  IndexChartInfoModelDTO(
      this.lowPrice,
      this.time,
      );

  static IndexChartInfoModelDTO fromResult(dynamic data) =>
      IndexChartInfoModelDTO.fromJson(data as Map<String, dynamic>);

  factory IndexChartInfoModelDTO.fromJson(dynamic json) =>
      _$IndexChartInfoModelDTOFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$IndexChartInfoModelDTOToJson(this);

}

extension IndexChartInfoModelMapper on IndexChartInfoModelDTO {
  IndexChartInfoModel toModel() {
    return IndexChartInfoModel(
      lowPrice: lowPrice ?? 0,
      time: time ?? 0,
    );
  }
}
