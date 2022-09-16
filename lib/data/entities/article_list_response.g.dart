// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListResponse _$ArticleListResponseFromJson(Map<String, dynamic> json) =>
    ArticleListResponse(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => NewsDetailModel.fromJson(e))
          .toList(),
      last: (json['last'] as num).toDouble(),
    );

Map<String, dynamic> _$ArticleListResponseToJson(
        ArticleListResponse instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'last': instance.last,
    };
