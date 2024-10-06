import 'package:bunker/supported_assets/model/supported_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../supported_assets/model/CryptoData.dart';
import '../../chart/line_chart.dart';
class AssetOverviewBox extends StatelessWidget {
  AssetOverviewBox({super.key,required this.asset, required this.h, required this.w, required this.color});
  SupportedCoin asset;
  double h;
  double w;
  Color color;
  List<QuoteElement> quotes=[];


  @override
  Widget build(BuildContext context) {
    quotes=asset.quotes??[];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 2.sp),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(
                text: "0.0000",
                color: primary_text_color,
                weight: FontWeight.w600,
                fontSize: 4.sp,
                align: TextAlign.start,
                maxLines: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                child: MyText(
                  text: asset.symbol,
                  color: primary_text_color.withOpacity(0.5),
                  weight: FontWeight.w600,
                  fontSize: 4.sp,
                  align: TextAlign.start,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          quotes.isNotEmpty?Expanded(
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
          ):const SizedBox(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.sp,
                height: 10.sp,
                child: CachedNetworkImage(
                  imageUrl: asset.image,
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
                      width: 10.sp,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      width: 10.sp,
                      height: 10.sp,
                      child: Icon(Icons.error,size: 10.sp,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                child: MyText(
                  text: asset.symbol,
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: 4.sp,
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
