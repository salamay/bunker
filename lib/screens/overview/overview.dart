import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/divider.dart';
import 'package:bunker/screens/overview/components/asset_overview_box.dart';
import 'package:bunker/screens/home/components/my_icon_button.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../components/texts/MyText.dart';

class OverView extends StatelessWidget {
  const OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.sp,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Overview",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: 10.sp,
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyIconButton(text: "Buy crypto", imageAsset: "assets/svgs/cart.svg",color: primary_color_button,),
              ],
            ),
            SizedBox(height: 8.sp,),
            SizedBox(
              height: 70.sp,
              child: Consumer<AssetController>(
                builder: (context, assetCtr, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Skeletonizer(
                      ignoreContainers: false,
                      enabled: assetCtr.assetLoading,
                      effect: ShimmerEffect(
                          duration: const Duration(milliseconds: 1000),
                          baseColor: secondary_color.withOpacity(0.1),
                          highlightColor: action_button_color.withOpacity(0.1)
                      ),
                      child: SizedBox(
                        width: width,
                        child: assetCtr.supportedCoin.isNotEmpty?Row(
                          children: assetCtr.supportedCoin.map((e){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AssetOverviewBox(
                                asset: e,
                                h: 100.sp,
                                w: 70.sp,
                                color: action_button_color.withOpacity(0.2),
                              ),
                            );
                          }).toList()
                        ):Skeleton.replace(
                          child: Container(
                            height: 100.sp,
                            width: 70.sp,
                            color: action_button_color.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: 10.sp,),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 6.sp),
              decoration: BoxDecoration(
                color: action_button_color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Account balance",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: 6.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: 1.sp,),
                  MyText(
                    text: "Your total balance across your account",
                    color: primary_text_color.withOpacity(0.6),
                    weight: FontWeight.w300,
                    fontSize: 4.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: 4.sp,),
                  Consumer<AssetController>(
                    builder: (context, assetCtr, child) {
                      return MyText(
                        text: "\$${assetCtr.overallBalance.toStringAsFixed(2)}",
                        color: primary_text_color,
                        weight: FontWeight.w700,
                        fontSize: 10.sp,
                        align: TextAlign.start,
                        maxLines: 3,
                      );
                    },
                  ),
                  SizedBox(height: 1.sp,),
                  MyText(
                    text: "Available balance",
                    color: primary_text_color.withOpacity(0.6),
                    weight: FontWeight.w300,
                    fontSize: 3.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  MyDivider(),
                  SizedBox(height: 2.sp,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyIconButton(text: "Send", imageAsset: "assets/svgs/send.svg",color: primary_color_button.withOpacity(0.1),fontSize: 4.sp,iconSize: 4.sp,w: 50.sp,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: MyIconButton(text: "Receive", imageAsset: "assets/svgs/receive.svg",color: primary_color_button.withOpacity(0.1),fontSize: 4.sp,iconSize: 4.sp,w: 50.sp),
                      ),
                    ],
                  ),
            
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
