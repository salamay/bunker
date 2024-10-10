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

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8.sp),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.sp,),
                MyText(
                  text: "Wallet",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: 10.sp,
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
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: "Total assets",
                    color: primary_text_color.withOpacity(0.6),
                    weight: FontWeight.w300,
                    fontSize: 3.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                ),
                MyDivider(),
                SizedBox(height: 2.sp,),
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
          SizedBox(width: 8.sp,),
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
