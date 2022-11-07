import 'package:json_annotation/json_annotation.dart';

import 'gold_model.dart';

part 'list_gold_response.g.dart';

@JsonSerializable()
class ListGoldResponse {
  String? updated;
  String? date;
  List<GoldModel>? values;
  int? lastTimeRequest;

  ListGoldResponse({
    this.updated,
    this.date,
    this.values,
    this.lastTimeRequest,
  });

  factory ListGoldResponse.fromJson(Map<String, dynamic> json) =>
      _$ListGoldResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListGoldResponseToJson(this);
}
