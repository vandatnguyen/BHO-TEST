// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      content: json['content'] as String?,
      id: json['id'] as int?,
      parentId: json['parentId'] as int?,
      articleId: json['articleId'] as String?,
      type: json['type'] as int?,
      numberLike: json['numberLike'] as int?,
      numberComment: json['numberComment'] as int?,
      createdDate: json['createdDate'] as int?,
      replys: json['replys'] == null
          ? null
          : CommentListResponse.fromJson(json['replys']),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'content': instance.content,
      'id': instance.id,
      'parentId': instance.parentId,
      'articleId': instance.articleId,
      'type': instance.type,
      'numberLike': instance.numberLike,
      'numberComment': instance.numberComment,
      'createdDate': instance.createdDate,
      'replys': instance.replys,
    };
