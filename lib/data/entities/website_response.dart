
import 'package:finews_module/data/entities/topic.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:json_annotation/json_annotation.dart';

part 'website_response.g.dart';

@JsonSerializable()
class WebsiteResponse {

  @JsonKey(name: "websites")
  final List<Website> websites;

  @JsonKey(name: "forum")
  final String forum;

  WebsiteResponse(this.websites, this.forum);

  static WebsiteResponse fromResult(dynamic data) =>
      WebsiteResponse.fromJson(data as Map<String, dynamic>);

  factory WebsiteResponse.fromJson(dynamic json) =>
      _$WebsiteResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$WebsiteResponseToJson(this);

}