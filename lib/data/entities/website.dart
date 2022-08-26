
import 'package:finews_module/data/entities/topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'website.g.dart';

@JsonSerializable()
class Website {

  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "topic")
  final List<Topic> topic;

  Website(this.id, this.name, this.topic);


  static Website fromResult(dynamic data) =>
      Website.fromJson(data as Map<String, dynamic>);

  factory Website.fromJson(dynamic json) =>
      _$WebsiteFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$WebsiteToJson(this);

}