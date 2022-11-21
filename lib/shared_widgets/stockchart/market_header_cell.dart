import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'LineChartCateComponent.dart';
import 'market_index_model.dart';
class MarketHeaderCell extends StatelessWidget {
  final MarketIndexModel stock;
  final VoidCallback onPressed;
  const MarketHeaderCell({
    Key? key,
    required this.stock,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width / 2,
        // clipBehavior: Clip.hardEdge,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: const Color(0xFFF5F6FA),
        // ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // SIZED_BOX_H08,
          Container(
            width: 80,
            color: HexColor.fromHex("#F5F6FA"),
            padding: const EdgeInsets.all(8.0),
            child: LineChartCateComponent(
              stock: stock,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stock.symbol ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'iCielHelveticaNowText-Medium',
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // SIZED_BOX_H02,
                        Row(
                          children: [
                            Text(
                              (stock.point ?? 0).toCurrency(symbol: ""),
                              style: TextStyle(
                                fontFamily: 'iCielHelveticaNowText',
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),Text(
                              "/ ${stock.ratioChange?.getRatioChange()}",
                              style: TextStyle(
                                fontFamily: 'iCielHelveticaNowText',
                                color: stock.getColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )

                      ]),
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}

extension CustomDoubleExtension on double {

  Color getStockColor() {
    if (this == 0) {
      return refColor;
    }
    if (this > 0) {
      return increaseColor;
    }
    return decreaseColor;
  }

  Color getStockColorWithCurrentPrice(double currentPrice) {
    if (this == currentPrice) {
      return refColor;
    }
    if (this > currentPrice) {
      return increaseColor;
    }
    return decreaseColor;
  }

  Color getStockColorWith(
      double ref,
      double floor,
      double ceil, {
        Color? colorDefault,
      }) {
    if (this == 0) return colorDefault ?? drawColor;
    if (this > ref && this < ceil) {
      return increaseColor;
    }

    if (this < ref && this > floor) {
      return decreaseColor;
    }

    if (this == floor) {
      return floorColor;
    }

    if (this == ceil) {
      return ceilColor;
    }

    return refColor;
  }

  String getRatioChange({String symbol = "%"}) {
    if (this == 0) {
      return "0,0$symbol";
    }
    if (this > 0) {
      return "+${this}$symbol".replaceAll(".", ",");
    }
    return "${this}$symbol".replaceAll(".", ",");
  }

  String getChange({String symbol = ""}) {
    if (this == 0) {
      return "0,0$symbol";
    }
    if (this > 0) {
      return "+${this / 1000}$symbol".replaceAll(".", ",");
    }
    return "${this / 1000}$symbol".replaceAll(".", ",");
  }

}