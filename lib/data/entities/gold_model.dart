import 'package:json_annotation/json_annotation.dart';

part 'gold_model.g.dart';

@JsonSerializable()
class GoldModel {
  String? id;
  String? day;
  String? buy;
  String? sell;
  String? company;
  String? brand;
  String? updated;
  String? brand1;
  String? type;
  String? code;
  String? logo;
  double? buy_change;
  double? sell_change;

  GoldModel({
    this.id,
    this.day,
    this.buy,
    this.sell,
    this.company,
    this.brand,
    this.updated,
    this.brand1,
    this.type,
    this.code,
    this.logo,
    this.buy_change,
    this.sell_change,
  });

  factory GoldModel.fromJson(Map<String, dynamic> json) => _$GoldModelFromJson(json);
  Map<String, dynamic> toJson() => _$GoldModelToJson(this);
}