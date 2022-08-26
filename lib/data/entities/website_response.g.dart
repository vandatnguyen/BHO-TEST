// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteResponse _$WebsiteResponseFromJson(Map<String, dynamic> json) =>
    WebsiteResponse(
      (json['websites'] as List<dynamic>)
          .map((e) => Website.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$WebsiteResponseToJson(WebsiteResponse instance) =>
    <String, dynamic>{
      'websites': instance.websites,
    };
