import 'package:json_annotation/json_annotation.dart';
part 'news_detail.g.dart';

@JsonSerializable()
class NewsDetailModel {
  @JsonKey(name: "articleId")
  final String id;

  @JsonKey(name: "origin")
  final String? origin;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "desc")
  final String? desc;

  @JsonKey(name: "content")
  final String? content;

  @JsonKey(name: "thumb")
  final String thumb;

  @JsonKey(name: "source")
  final int source;

  @JsonKey(name: "topic")
  final int topic;

  @JsonKey(name: "docbao24h")
  final String? docbao24h;

  @JsonKey(name: "tags")
  final List<String>? tags;

  @JsonKey(name: "webUrl")
  final String? webUrl;

  NewsDetailModel(
    this.id,
    this.origin,
    this.title,
    this.desc,
    this.content,
    this.thumb,
    this.source,
    this.topic,
    this.docbao24h,
    this.tags,
    this.webUrl,
  );

  static NewsDetailModel fromResult(dynamic data) =>
      NewsDetailModel.fromJson(data as Map<String, dynamic>);

  factory NewsDetailModel.fromJson(dynamic json) =>
      _$NewDetailModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$NewDetailModelToJson(this);
}
