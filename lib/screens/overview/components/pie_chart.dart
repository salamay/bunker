import 'dart:developer';
import 'dart:math' as math;

import 'package:bunker/components/app_component.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../supported_assets/model/assets.dart';
import '../../../utils/size_utils.dart';

class PieChartSample2 extends StatelessWidget {
  PieChartSample2({super.key});
  int touchedIndex = -1;
  late AssetController assetController;

  @override
  Widget build(BuildContext context) {
    assetController = Provider.of<AssetController>(context,listen: false);
    return Consumer<AssetController>(
      builder: (context, assetCtr, child) {
        return assetCtr.supportedCoin.isNotEmpty?PieChart(
          PieChartData(
            centerSpaceColor: action_button_color,
            pieTouchData: PieTouchData(
              // touchCallback: (FlTouchEvent event, pieTouchResponse) {
              //   setState(() {
              //     if (!event.isInterestedForInteractions ||
              //         pieTouchResponse == null ||
              //         pieTouchResponse.touchedSection == null) {
              //       touchedIndex = -1;
              //       return;
              //     }
              //     touchedIndex = pieTouchResponse
              //         .touchedSection!.touchedSectionIndex;
              //   });
              // },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: SizeUtils.getSize(context, 10.sp),
            sections: showingSections(assets: assetCtr.supportedCoin, context: context),
          ),
        ):const SizedBox();
      },
    );
  }

  List<PieChartSectionData>? showingSections({required context,required List<AssetModel> assets}) {
    if(assets.isEmpty){
      return null;
    }
    return List.generate(assets.length, (i) {
      double totalBalance = assets.fold(0, (previousValue, asset) => previousValue + asset.balance!);

      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? SizeUtils.getSize(context, 3.sp) : SizeUtils.getSize(context, 2.sp);
      final radius = isTouched ? SizeUtils.getSize(context, 10.sp) : SizeUtils.getSize(context, 8.sp);
      double percentage = (assets[i].balance! / totalBalance) * 100;
      return PieChartSectionData(
        color: assetController.colors[i],
        value: assets[i].balance,
        title: '${percentage.toStringAsFixed(2)}%', // Display percentage with 2 decimal places
        radius: radius,
        titleStyle: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: primary_text_color,
        ),
      );
    });
  }
}