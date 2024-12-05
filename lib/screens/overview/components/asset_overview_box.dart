import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../supported_assets/controller/asset_controller.dart';
import '../../../supported_assets/model/CryptoData.dart';
import '../../../utils/size_utils.dart';
import '../../chart/line_chart.dart';
import '../../home/components/listtile_shimmer.dart';
import '../../home/components/single_listtile_shimmer.dart';
class AssetOverviewBox extends StatelessWidget {
  AssetOverviewBox({super.key,required this.asset, required this.h, required this.w, required this.color});
  AssetModel asset;
  double h;
  double w;
  Color color;
  List<QuoteElement> quotes=[];
  late AssetController assetCtr;

  @override
  Widget build(BuildContext context) {
    quotes=asset.quotes??[];
    log("Quotes: ${asset.symbol} ${quotes.length}");
    assetCtr=Provider.of<AssetController>(context,listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 3.sp), horizontal: SizeUtils.getSize(context, 4.sp)),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 4.sp)),
        boxShadow: [
        BoxShadow(
        color: primary_color,
        spreadRadius: 5,
        ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            asset.balance!=null?"\$${asset.balance!.toStringAsFixed(2)}":"\$0.00",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: primary_text_color,
                fontSize: SizeUtils.getSize(context, 4.sp)
            ),
            maxLines: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
            child: MyText(
              text: asset.symbol!,
              color: primary_text_color.withOpacity(0.5),
              weight: FontWeight.w600,
              fontSize: SizeUtils.getSize(context,4.sp),
              align: TextAlign.start,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Skeletonizer(
              ignoreContainers: false,
              enabled: assetCtr.marketDataLoading,
              enableSwitchAnimation: true,
              effect: ShimmerEffect(
                  duration: const Duration(milliseconds: 1000),
                  baseColor: secondary_color.withOpacity(0.6),
                  highlightColor: action_button_color.withOpacity(0.8)
              ),
              child: SizedBox(
                child: LineChartSample2(
                  marketData: quotes,
                  areaColor: secondary_color.withOpacity(0.1),
                  gradientColors: <Color> [
                    secondary_color,
                    Colors.green,
                    secondary_color,
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: SizeUtils.getSize(context, 10.sp),
                height: SizeUtils.getSize(context, 10.sp),
                child: CachedNetworkImage(
                  imageUrl: asset.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Skeleton.replace(
                    child: Container(
                      width: SizeUtils.getSize(context, 10.sp),
                      height: SizeUtils.getSize(context, 10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, 8.sp))),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      width: SizeUtils.getSize(context, 10.sp),
                      height: SizeUtils.getSize(context, 10.sp),
                      child: Icon(Icons.error,size: SizeUtils.getSize(context, 10.sp),)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                child: MyText(
                  text: asset.symbol!,
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
