// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetailModel _$NewsDetailModelFromJson(Map<String, dynamic> json) =>
    NewsDetailModel(
      json['articleId'] as String,
      json['origin'] as String?,
      json['title'] as String,
      json['desc'] as String?,
      json['content'] as String?,
      json['thumb'] as String,
      json['source'] as int,
      json['topic'] as int,
      json['docbao24h'] as String?,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['symbols'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['webUrl'] as String?,
    );

Map<String, dynamic> _$NewsDetailModelToJson(NewsDetailModel instance) =>
    <String, dynamic>{
      'articleId': instance.id,
      'origin': instance.origin,
      'title': instance.title,
      'desc': instance.desc,
      'content': instance.content,
      'thumb': instance.thumb,
      'source': instance.source,
      'topic': instance.topic,
      'docbao24h': instance.docbao24h,
      'tags': instance.tags,
      'symbols': instance.symbols,
      'webUrl': instance.webUrl,
    };
