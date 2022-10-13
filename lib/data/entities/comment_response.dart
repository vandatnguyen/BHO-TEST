import 'package:finews_module/cores/models/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  @JsonKey(name: "comment")
  final CommentModel comment;

  @JsonKey(name: "total")
  final int total;

  CommentResponse({required this.comment, required this.total});

  factory CommentResponse.fromJson(dynamic json) =>
      _$CommentResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
