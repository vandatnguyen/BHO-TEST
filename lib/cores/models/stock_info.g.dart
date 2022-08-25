// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInfoModel _$StockInfoModelFromJson(Map<String, dynamic> json) =>
    StockInfoModel(
      json['symbol'] as String,
      (json['volume'] as num?)?.toDouble(),
      (json['price_current'] as num).toDouble(),
      (json['price_change'] as num?)?.toDouble(),
      (json['percent_change'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StockInfoModelToJson(StockInfoModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'volume': instance.volume,
      'price_current': instance.priceCurrent,
      'price_change': instance.priceChange,
      'percent_change': instance.percentChange,
    };
