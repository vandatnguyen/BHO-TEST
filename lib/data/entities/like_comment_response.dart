import 'package:json_annotation/json_annotation.dart';

part 'like_comment_response.g.dart';

@JsonSerializable()
class LikeCommentResponse {
  @JsonKey(name: "total")
  final int total;

  LikeCommentResponse({required this.total});

  factory LikeCommentResponse.fromJson(dynamic json) =>
      _$LikeCommentResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$LikeCommentResponseToJson(this);
}
