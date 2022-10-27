import 'package:finews_module/cores/models/stock_info.dart';
import 'package:finews_module/pages/home/main_tikop_provider.dart';
import 'package:finews_module/pages/home/main_trading_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsDetailStock extends StatelessWidget {
  final StockInfoModel model;

  const NewsDetailStock({Key? key, required this.model}) : super(key: key);

  String get price => (model.priceCurrent).toCurrency();

  String get grow =>
      (model.priceChange ?? 0).toCurrency() +
      "/" +
      (model.percentChange ?? 0).toPercentCurrency();

  String get total => (model.volume ?? 0.0).toCurrency();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFFF4F5F6),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          model.symbol,
                          style: const TextStyle(
                              color: Color(0xFF58BD7D),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Giá",
                            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            price,
                            style: const TextStyle(
                                color: Color(0xFF23262F),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tăng trưởng",
                            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            grow,
                            style: TextStyle(
                                color: Color(0xFFFF3B30),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tổng KL",
                            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            total,
                            style: TextStyle(
                                color: Color(0xFF23262F),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )),
      onTap: () {
        try {
          // Get.find<MainFiNewsTradingProvider>().openStockDetail?.call(model.symbol);
          Get.find<MainFiNewsTikopProvider>().openStockDetail?.call(model.symbol);
        } catch (e) {
          print(e);
        }
      },
    );
  }
}

extension DoubleCurrency on double {
  String toPercentCurrency() {
    if (this == 0) {
      return "0%";
    }
    var formatter = NumberFormat('+#.##;-#.##');
    return formatter.format(this) + "%";
  }

  String toCurrency() {
    if (this == 0) {
      return "0.0";
    }
    var formatter = NumberFormat('#.##');
    return formatter.format(this);
  }
}
