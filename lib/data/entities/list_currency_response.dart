import 'package:finews_module/data/entities/currency_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_currency_response.g.dart';

@JsonSerializable()
class ListCurrencyResponse {
  String? bank;
  String? brand;
  int? updated;
  String? date;
  int? version;
  List<CurrencyModel>? value;
  int? lastTimeRequest;

  ListCurrencyResponse({
    this.bank,
    this.brand,
    this.updated,
    this.date,
    this.version,
    this.value,
    this.lastTimeRequest,
  });

  factory ListCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCurrencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCurrencyResponseToJson(this);
}
