// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_list_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentListResponse _$CommentListResponseFromJson(Map<String, dynamic> json) =>
    CommentListResponse(
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
    );

Map<String, dynamic> _$CommentListResponseToJson(
        CommentListResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'total': instance.total,
    };
