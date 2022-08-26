
import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {

  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "is_hot")
  final bool is_hot;

  Topic(this.id, this.name, this.is_hot);

  static Topic fromResult(dynamic data) =>
      Topic.fromJson(data as Map<String, dynamic>);

  factory Topic.fromJson(dynamic json) =>
      _$TopicFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}