import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/wallet/components/wallet_item.dart';
import 'package:bunker/screens/wallet/controller/wallet_controller.dart';
import 'package:bunker/screens/wallet/send_and_receive_modal.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../components/divider.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: Row(
        children: [
          Container(
            width: width * 0.3,
            decoration: BoxDecoration(
                color: secondary_color,
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
                SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: "Wallet",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: SizeUtils.getSize(context, 10.sp),
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<AssetController>(
                    builder: (context, assetCtr, child) {
                      return MyText(
                        text: "\$${assetCtr.overallBalance.toStringAsFixed(2)}",
                        color: primary_text_color,
                        weight: FontWeight.w700,
                        fontSize: SizeUtils.getSize(context, 10.sp),
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
                Consumer<AssetController>(
                  builder: (context, assetCtr, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: assetCtr.supportedCoin.map((e) {
                        return WalletItem(asset: e,callback:(){
                          int i=assetCtr.supportedCoin.indexOf(e);
                          log("index $i");
                          Provider.of<WalletController>(context,listen: false).changeIndex(i);
                        });
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(width: SizeUtils.getSize(context, 8.sp),),
          Expanded(
            child: Consumer<WalletController>(
              builder: (context, walletCtr, child) {
                AssetController assetCtr = Provider.of<AssetController>(context,listen: false);
                log("selected index ${walletCtr.selectedIndex}");
                if(assetCtr.supportedCoin.isNotEmpty){
                  AssetModel selectedAsset=assetCtr.supportedCoin[walletCtr.selectedIndex];
                  return SendAndReceiveModal(asset: selectedAsset,);
                }else{
                  return SizedBox();
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
