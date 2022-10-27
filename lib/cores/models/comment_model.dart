import 'package:finews_module/data/entities/comment_list_article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String? userName;
  String? email;
  String? content;
  int? id;
  int? parentId;
  String? articleId;
  int? type;
  int? numberLike;
  int? numberComment;
  int? createdDate;
  CommentListResponse? replys;

  CommentModel({
    this.userName,
    this.email,
    this.content,
    this.id,
    this.parentId,
    this.articleId,
    this.type,
    this.numberLike,
    this.numberComment,
    this.createdDate,
    this.replys,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
