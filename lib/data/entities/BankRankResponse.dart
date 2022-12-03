import 'package:finews_module/data/entities/rate_model.dart';

class BankRateResponse {
  String? message;
  List<BankRate>? data;
  int? lastTimeRequest;

  BankRateResponse({this.message, this.data, this.lastTimeRequest});

  BankRateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <BankRate>[];
      json['data'].forEach((v) {
        data!.add(BankRate.fromJson(v));
      });
    }
    lastTimeRequest = json['last_time_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_time_request'] = this.lastTimeRequest;
    return data;
  }
}