import 'package:finews_module/cores/models/stock_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
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

  @JsonKey(name: "symbols")
  final List<String>? symbols;

  @JsonKey(name: "webUrl")
  final String? webUrl;

  @JsonKey(name: "stock_info")
  final List<StockInfoModel>? stockInfo;

  @JsonKey(name: "pubdate")
  final int? pubdate;

  String? topicName = "";
  String? sourceName = "";

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
      
      this.symbols,
      this.webUrl
      this.stockInfo,
      this.pubdate);

  static NewsDetailModel fromResult(dynamic data) =>
      NewsDetailModel.fromJson(data as Map<String, dynamic>);

  factory NewsDetailModel.fromJson(dynamic json) =>
      _$NewsDetailModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$NewsDetailModelToJson(this);
}

extension DateExtension on NewsDetailModel {
  DateTime get createdDateTime {
    if (pubdate == null) {
      return DateTime.now();
    }
    return DateTime.fromMillisecondsSinceEpoch(pubdate!);
  }

  String formatDisplayDate() {
    final current = DateTime.now();
    final diff = current.difference(createdDateTime);
    var outputFormat = DateFormat('HH:mmm dd/MM/yyyy');

    return outputFormat.format(current);
  }

  String formatDisplayTime() {
    final current = DateTime.now();
    final diff = current.difference(createdDateTime);
    var outputFormat = DateFormat('HH:mmm');

    return outputFormat.format(current);
  }
}
