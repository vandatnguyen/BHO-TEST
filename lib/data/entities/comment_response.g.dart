// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      comment: CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
      total: json['total'] as int,
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'total': instance.total,
    };
