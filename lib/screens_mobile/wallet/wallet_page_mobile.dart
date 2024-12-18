import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/wallet/components/wallet_item.dart';
import 'package:bunker/screens/wallet/controller/wallet_controller.dart';
import 'package:bunker/screens/wallet/send_and_receive_modal.dart';
import 'package:bunker/screens_mobile/wallet/send_and_receive_modal_mobile.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/divider.dart';
import '../../components/texts/MyText.dart';
import '../../screens/empty/empty_page.dart';
import '../../screens/home/components/listtile_shimmer.dart';
import '../../screens/transaction/controller/transaction_controller.dart';
import '../../screens/transaction/model/transaction_model.dart';
import '../../screens/transaction/transaction_item.dart';
import '../../utils/size_utils.dart';
import 'components/wallet_item_mobile.dart';

class WalletPageMobile extends StatelessWidget {
  WalletPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: secondary_color,
                        boxShadow: [
                          BoxShadow(
                            color: primary_color,
                            spreadRadius: 5,
                          ),
                        ]
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                          Align(
                            alignment: Alignment.center,
                            child: MyText(
                              text: "Wallet",
                              color: primary_text_color,
                              weight: FontWeight.w600,
                              fontSize: SizeUtils.getSize(context, 4.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Consumer<AssetController>(
                              builder: (context, assetCtr, child) {
                                return MyText(
                                  text: "\$${assetCtr.overallBalance.toStringAsFixed(2)}",
                                  color: primary_text_color,
                                  weight: FontWeight.w700,
                                  fontSize: SizeUtils.getSize(context, 6.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                          Align(
                            alignment: Alignment.center,
                            child: MyText(
                              text: "Total assets",
                              color: primary_text_color.withOpacity(0.6),
                              weight: FontWeight.w300,
                              fontSize: SizeUtils.getSize(context, 3.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          MyDivider(),
                          SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                          SingleChildScrollView(
                            child: Consumer<AssetController>(
                              builder: (context, assetCtr, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: assetCtr.supportedCoin.map((e) {
                                    return WalletItemMobile(asset: e,callback:(){
                                      int i=assetCtr.supportedCoin.indexOf(e);
                                      log("index $i");
                                      Provider.of<WalletController>(context,listen: false).changeIndex(i);
                                    });
                                  }).toList(),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                Expanded(
                  child: Consumer<WalletController>(
                    builder: (context, walletCtr, child) {
                      AssetController assetCtr = Provider.of<AssetController>(context,listen: false);
                      log("selected index ${walletCtr.selectedIndex}");
                      if(assetCtr.supportedCoin.isNotEmpty){
                        AssetModel selectedAsset=assetCtr.supportedCoin[walletCtr.selectedIndex];
                        return SendAndReceiveModalMobile(asset: selectedAsset,);
                      }else{
                        return SizedBox();
                      }

                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtils.getSize(context, 4.sp),),
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
