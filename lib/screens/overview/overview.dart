import 'dart:ui';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/divider.dart';
import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/buy_crypto/buy_crypto_dialog.dart';
import 'package:bunker/screens/home/components/listtile_shimmer.dart';
import 'package:bunker/screens/home/components/single_listtile_shimmer.dart';
import 'package:bunker/screens/home/controller/home_controller.dart';
import 'package:bunker/screens/overview/components/asset_overview_box.dart';
import 'package:bunker/screens/home/components/my_icon_button.dart';
import 'package:bunker/screens/overview/components/pie_chart.dart';
import 'package:bunker/screens/overview/model/payment_gateway.dart';
import 'package:bunker/screens/transaction/model/transaction_model.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../components/texts/MyText.dart';
import '../account/model/profile_model.dart';
import '../empty/empty_page.dart';
import '../transaction/controller/transaction_controller.dart';
import '../transaction/transaction_item.dart';
import '../wallet/controller/wallet_controller.dart';

class OverView extends StatelessWidget {
  OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical:SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:SizeUtils.getSize(context, 8.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Overview",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: SizeUtils.getSize(context, 6.sp),
                  align: TextAlign.start,
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: (){
                    showAdaptiveDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context){
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: AlertDialog(
                              scrollable: true,
                              backgroundColor: primary_color,
                              content: Container(
                                height: height*0.4,
                                width: width*0.3,
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 6.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                                ),
                                child: BuyCryptoDialog(),
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: MyIconButton(
                    text: "Buy crypto",
                    imageAsset: "assets/svgs/cart.svg",
                    color: primary_color_button,
                  ),
                )
              ],
            ),
            SizedBox(height: SizeUtils.getSize(context, 8.sp)),
            SizedBox(
              height: SizeUtils.getSize(context, 70.sp),
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Consumer<AssetController>(
                      builder: (context, assetCtr, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Skeletonizer(
                            ignoreContainers: false,
                            enabled: assetCtr.assetLoading,
                            enableSwitchAnimation: true,
                            effect: ShimmerEffect(
                                duration: const Duration(milliseconds: 1000),
                                baseColor: secondary_color.withOpacity(0.6),
                                highlightColor: action_button_color.withOpacity(0.8)
                            ),
                            child: SizedBox(
                              child: !assetCtr.assetLoading?assetCtr.supportedCoin.isNotEmpty?Row(
                                children: assetCtr.supportedCoin.sublist(0,3).map((e){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AssetOverviewBox(
                                      asset: e,
                                      quotes: assetCtr.quotes[e.marketId!]??[],
                                      h: SizeUtils.getSize(context, 100.sp),
                                      w: SizeUtils.getSize(context, 70.sp),
                                      color: action_button_color.withOpacity(0.3),
                                    ),
                                  );
                                }).toList()
                              ):EmptyPage(title: "Oops! Nothing is here", subtitle: "Assets are empty"):Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
                                ),
                                height: SizeUtils.getSize(context, 100.sp),
                                width: SizeUtils.getSize(context, 70.sp),
                                child: const SingleListTileShimmer(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Consumer<AccountSettingController>(
                        builder: (context, accountCtr, child) {
                          ProfileModel? profileModel = accountCtr.profileModel;
                          if(profileModel!=null){
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  profileModel.kycEnabled!?"assets/svgs/verification_green.svg":"assets/svgs/verification_orange.svg",
                                  width: SizeUtils.getSize(context, 50.sp),
                                  height: SizeUtils.getSize(context, 50.sp),
                                ),
                                MyText(
                                  text: profileModel.kycEnabled!?"KYC verified":"Unverified",
                                  color: primary_text_color,
                                  weight: FontWeight.w400,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center,
                                  maxLines: 1,
                                ),
                                MyText(
                                  text: profileModel.kycEnabled!?"You are now a verified user":"You are not yet a verified user",
                                  color: primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 3.sp),
                                  align: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ],
                            );
                          }else{
                            return const SizedBox();
                          }
                      }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeUtils.getSize(context, 2.sp),),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 4.sp), horizontal: SizeUtils.getSize(context, 2.sp)),
              decoration: BoxDecoration(
                color: secondary_color,
                borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
                  boxShadow: [
                    BoxShadow(
                      color: primary_color,
                      spreadRadius: 5,
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AssetController>(
                      builder: (context, assetCtr, child) {
                      return Skeletonizer(
                        ignoreContainers: false,
                        enabled: assetCtr.assetLoading,
                        enableSwitchAnimation: true,
                        effect: ShimmerEffect(
                            duration: const Duration(milliseconds: 1000),
                            baseColor: secondary_color.withOpacity(0.6),
                            highlightColor: action_button_color.withOpacity(0.8)
                        ),
                        child: SizedBox(
                          width: width,
                          child: !assetCtr.assetLoading?assetCtr.supportedCoin.isNotEmpty?Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //     width: SizeUtils.getSize(context, 20.sp),
                              //     height: SizeUtils.getSize(context, 30.sp),
                              //     child: PieChartSample2()
                              // ),
                              SizedBox(width: SizeUtils.getSize(context, 8.sp),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "Account balance",
                                    color: primary_text_color,
                                    weight: FontWeight.w600,
                                    fontSize: SizeUtils.getSize(context, 4.sp),
                                    align: TextAlign.start,
                                    maxLines: 3,
                                  ),
                                  SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                                  MyText(
                                    text: "Your total balance across your account",
                                    color: primary_text_color.withOpacity(0.6),
                                    weight: FontWeight.w300,
                                    fontSize: SizeUtils.getSize(context, 3.sp),
                                    align: TextAlign.start,
                                    maxLines: 3,
                                  ),
                                  SizedBox(height: SizeUtils.getSize(context, 3.sp),),
                                  Consumer<AssetController>(
                                    builder: (context, assetCtr, child) {
                                      return MyText(
                                        text: "\$${assetCtr.overallBalance.toStringAsFixed(2)}",
                                        color: primary_text_color,
                                        weight: FontWeight.w600,
                                        fontSize: SizeUtils.getSize(context, 5.sp),
                                        align: TextAlign.start,
                                        maxLines: 1,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ):EmptyPage(title: "Oops! Nothing is here", subtitle: "Assets are empty"):Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
                            ),
                            height: SizeUtils.getSize(context, 100.sp),
                            width: SizeUtils.getSize(context, 70.sp),
                            child: const ListTileShimmer(),
                          ),
                        ),
                      );
                    }
                  ),
                  MyDivider(),
                  SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          WalletController walletController=Provider.of<WalletController>(context,listen: false);
                          walletController.changeModal(false);
                          Provider.of<HomeController>(context,listen: false).changePage(2);
                        },
                          child: MyIconButton(text: "Send", imageAsset: "assets/svgs/send.svg",color: primary_color_button,fontSize: SizeUtils.getSize(context, 4.sp),iconSize: SizeUtils.getSize(context, 4.sp),w: SizeUtils.getSize(context, 50.sp),)
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, SizeUtils.getSize(context, 3.sp))),
                        child: GestureDetector(
                            onTap: (){
                              WalletController walletController=Provider.of<WalletController>(context,listen: false);
                              walletController.changeModal(true);
                              Provider.of<HomeController>(context,listen: false).changePage(2);
                            },
                            child: MyIconButton(text: "Receive", imageAsset: "assets/svgs/receive.svg",color: primary_color_button,fontSize: SizeUtils.getSize(context, 4.sp),iconSize: SizeUtils.getSize(context, 4.sp),w: SizeUtils.getSize(context, 50.sp))
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeUtils.getSize(context, 2.sp),),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 4.sp), horizontal: SizeUtils.getSize(context, 2.sp)),
              decoration: BoxDecoration(
                  color: secondary_color,
                  borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
                  boxShadow: [
                    BoxShadow(
                      color: primary_color,
                      spreadRadius: 5,
                    ),
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Transactions",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: SizeUtils.getSize(context, 4.sp),
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                  Consumer<TransactionController>(
                      builder: (context, transactionCtr, child) {
                        List<TransactionModel> tx=transactionCtr.transactions.length<=5?transactionCtr.transactions:transactionCtr.transactions.sublist(0,5);
                      return Skeletonizer(
                        ignoreContainers: false,
                        enabled: transactionCtr.transactionLoading,
                        enableSwitchAnimation: true,
                        effect: ShimmerEffect(
                            duration: const Duration(milliseconds: 1000),
                            baseColor: secondary_color.withOpacity(0.6),
                            highlightColor: action_button_color.withOpacity(0.8)
                        ),
                        child: !transactionCtr.transactionLoading? tx.isEmpty?Container(
                          width: width,
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: secondary_color.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                          ),
                          child: EmptyPage(
                              title: "Oops! Nothing is here",
                              subtitle: "We couldn't find any transaction"
                          ),
                        ):Column(
                          children: tx.map((e) => Container(
                            padding: EdgeInsets.only(bottom: SizeUtils.getSize(context, 2.sp)),
                            child: TransactionItem(transactionModel: e),
                          )).toList(),
                        ):const ListTileShimmer(),
                      );
                    }
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
