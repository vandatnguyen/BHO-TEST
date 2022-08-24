import 'package:finews_module/cores/models/news_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_list_response.g.dart';

@JsonSerializable()
class ArticleListResponse {

  @JsonKey(name: "articles")
  final List<NewsDetailModel> articles;

  ArticleListResponse({required this.articles});


  static ArticleListResponse fromResult(dynamic data) =>
      ArticleListResponse.fromJson(data as Map<String, dynamic>);

  factory ArticleListResponse.fromJson(dynamic json) =>
      _$ArticleListResponseFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ArticleListResponseToJson(this);
}
