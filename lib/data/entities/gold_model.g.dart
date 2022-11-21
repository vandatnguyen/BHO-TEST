// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldModel _$GoldModelFromJson(Map<String, dynamic> json) => GoldModel(
      id: json['id'] as String?,
      day: json['day'] as String?,
      buy: json['buy'] as String?,
      sell: json['sell'] as String?,
      company: json['company'] as String?,
      brand: json['brand'] as String?,
      updated: json['updated'] as String?,
      brand1: json['brand1'] as String?,
      type: json['type'] as String?,
      code: json['code'] as String?,
      logo: json['logo'] as String?,
      buy_change: (json['buy_change'] as num?)?.toDouble(),
      sell_change: (json['sell_change'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GoldModelToJson(GoldModel instance) => <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'buy': instance.buy,
      'sell': instance.sell,
      'company': instance.company,
      'brand': instance.brand,
      'updated': instance.updated,
      'brand1': instance.brand1,
      'type': instance.type,
      'code': instance.code,
      'logo': instance.logo,
      'buy_change': instance.buy_change,
      'sell_change': instance.sell_change,
    };
