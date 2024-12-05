import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/app_component.dart';
import '../../supported_assets/model/CryptoData.dart';

class LineChartSample2 extends StatelessWidget {
  LineChartSample2({required this.marketData, required this.areaColor,required this.gradientColors,super.key});
  List<QuoteElement>? marketData;
  Color areaColor;
  List<Color> gradientColors = [
    Colors.green,
    secondary_color,
  ];
  List<Color> areaGradient = [
    Colors.green,
    secondary_color,
  ];

  List<QuoteElement> prices=[];

  @override
  Widget build(BuildContext context) {
    if(marketData!=null){
      if(marketData!.isNotEmpty){
        int end=marketData!.length;
        double start=(marketData!.length)*0.85;
        prices=marketData!.sublist(start.toInt(),end);
        num firstPrice=marketData!.first.quote!.usd!.price!;
        num lastPrice=marketData!.last.quote!.usd!.price!;
        // log("firstPrice: $firstPrice");
        num difference = lastPrice - firstPrice;
        double percentage = (difference / firstPrice) * 100;
        if(!percentage.isNegative){
          gradientColors=[Colors.green.withOpacity(0.3),Colors.green];
          areaGradient=[Colors.green.withOpacity(0.3),Colors.green.withOpacity(0.001)];
        }else{
          gradientColors=[Colors.red.withOpacity(0.3),Colors.red];
          areaGradient=[Colors.red.withOpacity(0.3),Colors.red.withOpacity(0.001)];
        }
      }

    }
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.transparent,
                  strokeWidth: 0.5.sp,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.transparent,
                  strokeWidth: 0.5.sp,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: false,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: false,
              border: Border.all(color: Colors.transparent),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: prices.isNotEmpty?prices
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value.quote!.usd!.price!.toDouble()))
                    .toList():[FlSpot(0,0)],
                isCurved: false,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                barWidth: 0.5.sp,
                isStrokeCapRound: false,
                dotData: const FlDotData(
                  show: false,
                ),
                aboveBarData: BarAreaData(
                    show: true,
                    color: Colors.transparent
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: areaGradient,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}