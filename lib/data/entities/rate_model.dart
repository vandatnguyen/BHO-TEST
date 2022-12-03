class BankRate {
  String? bank;
  double? noRate;
  double? rate1;
  double? rate3;
  int? isApp;
  String? logo;

  BankRate({this.bank, this.noRate, this.rate1, this.rate3, this.isApp, this.logo});

  BankRate.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    noRate = json['no_rate'];
    rate1 = json['rate_1'];
    rate3 = json['rate_3'];
    isApp = json['isApp'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['no_rate'] = this.noRate;
    data['rate_1'] = this.rate1;
    data['rate_3'] = this.rate3;
    data['isApp'] = this.isApp;
    data['logo'] = this.logo;
    return data;
  }
}