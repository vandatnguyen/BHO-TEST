import 'package:finews_module/cores/models/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_list_article.g.dart';

@JsonSerializable()
class CommentListResponse {
  @JsonKey(name: "comments")
  final List<CommentModel> comments;

  @JsonKey(name: "total")
  final int total;

  CommentListResponse({required this.comments, required this.total});

  factory CommentListResponse.fromJson(dynamic json) =>
      _$CommentListResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$CommentListResponseToJson(this);
}
