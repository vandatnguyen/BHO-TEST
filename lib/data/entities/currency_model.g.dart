// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      buy: json['buy'] as String?,
      sell: json['sell'] as String?,
      transfer: json['transfer'] as String?,
      id: json['id'] as String?,
      order: json['order'] as String?,
      name: json['name'] as String?,
      fullName: json['fullName'] as String?,
      day: json['day'] as String?,
      code: json['code'] as String?,
      buy_change: (json['buy_change'] as num?)?.toDouble(),
      sell_change: (json['sell_change'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'buy': instance.buy,
      'sell': instance.sell,
      'transfer': instance.transfer,
      'id': instance.id,
      'order': instance.order,
      'name': instance.name,
      'fullName': instance.fullName,
      'day': instance.day,
      'code': instance.code,
      'buy_change': instance.buy_change,
      'sell_change': instance.sell_change,
    };
