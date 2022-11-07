// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_currency_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCurrencyResponse _$ListCurrencyResponseFromJson(
        Map<String, dynamic> json) =>
    ListCurrencyResponse(
      bank: json['bank'] as String?,
      brand: json['brand'] as String?,
      updated: json['updated'] as int?,
      date: json['date'] as String?,
      version: json['version'] as int?,
      value: (json['value'] as List<dynamic>?)
          ?.map((e) => CurrencyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastTimeRequest: json['lastTimeRequest'] as int?,
    );

Map<String, dynamic> _$ListCurrencyResponseToJson(
        ListCurrencyResponse instance) =>
    <String, dynamic>{
      'bank': instance.bank,
      'brand': instance.brand,
      'updated': instance.updated,
      'date': instance.date,
      'version': instance.version,
      'value': instance.value,
      'lastTimeRequest': instance.lastTimeRequest,
    };
