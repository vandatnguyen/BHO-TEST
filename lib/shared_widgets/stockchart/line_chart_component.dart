import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/shared_widgets/stockchart/stock_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LineChartComponent
    extends StatelessWidget {
  const LineChartComponent({
    Key? key,
    required this.stock,
  }) : super(key: key);
  final StockModel stock;
  //T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SIZED_BOX_H04,
        SizedBox(
          height: 32,
          child: Padding(
            padding: PAD_SYM_H12,
            child: _LineChartComponent(
              stock: stock,
            ),
          ),
        ),
      ],
    );
  }
}


class _LineChartComponent
    extends StatelessWidget {
  const _LineChartComponent({Key? key, required this.stock})
      : super(key: key);
  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (_) {},
      child: Obx(() {
        final spots = stock.flSpots.toList();
        if (stock.flSpots.isEmpty) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Colors.green,
              size: 20,
            ),
          );
        }

        final List<Color> _gradientColors = [
          //stock.getColor().withOpacity(0.001),
          const Color(0xFFFFFFFF),
          const Color(0xFFFFFFFF),
        ];


        final data = [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: [stock.getColor()],
            isStepLineChart: true,
            lineChartStepData: LineChartStepData(stepDirection: 0.65),
            barWidth: 1.5,
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
      }),
    );
  }
}
