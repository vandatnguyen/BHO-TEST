import 'package:json_annotation/json_annotation.dart';

part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel {
  String? buy;
  String? sell;
  String? transfer;
  String? id;
  String? order;
  String? name;
  String? fullName;
  String? day;
  String? code;
  double? buy_change;
  double? sell_change;

  CurrencyModel({
    this.buy,
    this.sell,
    this.transfer,
    this.id,
    this.order,
    this.name,
    this.fullName,
    this.day,
    this.code,
    this.buy_change,
    this.sell_change,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
