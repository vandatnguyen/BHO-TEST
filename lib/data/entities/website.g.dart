// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Website _$WebsiteFromJson(Map<String, dynamic> json) => Website(
      json['id'] as int,
      json['name'] as String,
      (json['topic'] as List<dynamic>).map((e) => Topic.fromJson(e)).toList(),
    );

Map<String, dynamic> _$WebsiteToJson(Website instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'topic': instance.topic,
    };
