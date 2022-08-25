import 'package:json_annotation/json_annotation.dart';
part 'stock_info.g.dart';

@JsonSerializable()
class StockInfoModel {
  @JsonKey(name: "symbol")
  final String symbol;

  @JsonKey(name: "volume")
  final double? volume;

  @JsonKey(name: "price_current")
  final double priceCurrent;

  @JsonKey(name: "price_change")
  final double? priceChange;

  @JsonKey(name: "percent_change")
  final double? percentChange;

  StockInfoModel(
    this.symbol,
    this.volume,
    this.priceCurrent,
    this.priceChange,
    this.percentChange,
  );

  static StockInfoModel fromResult(dynamic data) =>
      StockInfoModel.fromJson(data as Map<String, dynamic>);

  factory StockInfoModel.fromJson(dynamic json) =>
      _$StockInfoModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$StockInfoModelToJson(this);
}
