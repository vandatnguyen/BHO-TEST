// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_index_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketIndexModelDTO _$MarketIndexModelDTOFromJson(Map<String, dynamic> json) =>
    MarketIndexModelDTO(
      json['symbol'] as String?,
      (json['point'] as num?)?.toDouble(),
      (json['change'] as num?)?.toDouble(),
      (json['ratioChange'] as num?)?.toDouble(),
      (json['tradingValue'] as num?)?.toDouble(),
      (json['tradingVolume'] as num?)?.toDouble(),
      (json['refPrice'] as num?)?.toDouble(),
      (json['charts'] as List<dynamic>?)
          ?.map((e) => IndexChartInfoModelDTO.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$MarketIndexModelDTOToJson(
        MarketIndexModelDTO instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'point': instance.point,
      'change': instance.change,
      'ratioChange': instance.ratioChange,
      'tradingValue': instance.tradingValue,
      'tradingVolume': instance.tradingVolume,
      'refPrice': instance.refPrice,
      'charts': instance.charts,
    };

IndexChartInfoModelDTO _$IndexChartInfoModelDTOFromJson(
        Map<String, dynamic> json) =>
    IndexChartInfoModelDTO(
      (json['lowPrice'] as num?)?.toDouble(),
      (json['time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IndexChartInfoModelDTOToJson(
        IndexChartInfoModelDTO instance) =>
    <String, dynamic>{
      'lowPrice': instance.lowPrice,
      'time': instance.time,
    };
