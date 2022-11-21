import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:trading_module/src/configs/constants.dart';

import 'market_index_model.dart';

class LineChartCateComponent extends StatelessWidget {
  const LineChartCateComponent({
    Key? key,
    required this.stock,
  }) : super(key: key);

  final MarketIndexModel stock;

  //T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: PAD_SYM_H12,
            child: _LineChartCateComponent(
              stock: stock,
            ),
          ),
        ),
      ],
    );
  }
}

const PAD_SYM_H12 = EdgeInsets.symmetric(horizontal: 0);

class _LineChartCateComponent extends StatelessWidget {
  const _LineChartCateComponent({Key? key, required this.stock})
      : super(key: key);
  final MarketIndexModel stock;

  @override
  Widget build(BuildContext context) {
    int ratio = 1;
    return Obx(() {
      final spots = stock.flSpots.toList();
      if (spots.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final List<Color> _gradientColors = [
        //stock.getColor().withOpacity(0.001),
        Colors.transparent,
        Colors.transparent,
      ];
      final List<Color> chartColor = [const Color(0xFF00B14F)];
      final chartLen = stock.charts?.length ?? 0;
      final ref = stock.refPrice ??
          (stock.charts != null ? stock.charts![0].lowPrice : 0.0);
      //final ref = stock.charts != null ? stock.charts![0].lowPrice : 0.0;
      if (chartLen > 576) {
        ratio = (chartLen / 288).floor();
      }
      for (int i = 0; i < chartLen; i += ratio) {
        if (stock.charts![i].lowPrice < ref) {
          chartColor.add(const Color(0xFFF46666));
        } else {
          chartColor.add(const Color(0xFF00B14F));
        }
      }
      final data = [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: chartColor,
          isStepLineChart: true,
          lineChartStepData: LineChartStepData(stepDirection: 0.65),
          barWidth: 1,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors: _gradientColors,
            gradientTo: const Offset(0.0, 1.0),
            gradientFrom: const Offset(0.0, 0.5),
          ),
        )
      ];
      return LineChart(
        LineChartData(
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: ref,
                color: Colors.black.withOpacity(0.4),
                strokeWidth: 0.5,
                dashArray: [3, 2],
                label: HorizontalLineLabel(
                  padding: const EdgeInsets.only(top: 10),
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF333333).withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
            ],
          ),
          lineBarsData: data,
          lineTouchData: LineTouchData(
            enabled: false,
          ),
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
            border: const Border(
              bottom: BorderSide(
                color: Color(0xff4e4965),
                width: 0.5,
              ),
            ),
          ),
          minX: stock.chartRange.value.minX,
          maxX: stock.chartRange.value.maxX,
          minY: stock.chartRange.value.minY,
          maxY: stock.chartRange.value.maxY,
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
      );
    });
  }
}
