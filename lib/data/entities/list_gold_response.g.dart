// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_gold_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListGoldResponse _$ListGoldResponseFromJson(Map<String, dynamic> json) =>
    ListGoldResponse(
      updated: json['updated'] as String?,
      date: json['date'] as String?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => GoldModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastTimeRequest: json['lastTimeRequest'] as int?,
    );

Map<String, dynamic> _$ListGoldResponseToJson(ListGoldResponse instance) =>
    <String, dynamic>{
      'updated': instance.updated,
      'date': instance.date,
      'values': instance.values,
      'lastTimeRequest': instance.lastTimeRequest,
    };
