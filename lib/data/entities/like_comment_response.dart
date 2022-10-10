import 'package:finews_module/cores/models/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'like_comment_response.g.dart';

@JsonSerializable()
class LikeCommentResponse {
  @JsonKey(name: "total")
  final int total;

  LikeCommentResponse({required this.total});

  factory LikeCommentResponse.fromJson(dynamic json) =>
      _$CommentResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
