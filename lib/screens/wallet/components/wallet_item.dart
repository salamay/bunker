import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/wallet/controller/wallet_controller.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/texts/MyText.dart';
class WalletItem extends StatelessWidget {
  WalletItem({super.key,required this.asset,required this.callback});
  AssetModel asset;
  Function callback;
  late AssetController assetController;
  @override
  Widget build(BuildContext context) {
    assetController=Provider.of<AssetController>(context,listen: false);
    return Consumer<WalletController>(
      builder: (context, walletCtr, child) {
        return Material(
          borderRadius: BorderRadius.circular(cornerRadius),
          color: Colors.transparent,
          child: ListTile(
            hoverColor: action_button_color.withOpacity(0.1),
            tileColor: walletCtr.selectedIndex==assetController.supportedCoin.indexOf(asset)?secondary_color.withOpacity(0.8):Colors.transparent,
            contentPadding: EdgeInsets.symmetric(vertical: 1.sp,horizontal: 4.sp),
            onTap: (){
              callback.call();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            leading: SizedBox(
              width: 10.sp,
              height: 10.sp,
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
            title: MyText(
              text: asset.name!,
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w400,
              fontSize: 4.sp,
              align: TextAlign.start,
              maxLines: 3,
            ),
            subtitle: MyText(
              text: asset.symbol!,
              color: primary_text_color.withOpacity(0.6),
              weight: FontWeight.w300,
              fontSize: 3.sp,
              align: TextAlign.start,
              maxLines: 3,
            ),
            trailing: MyText(
              text: assetController.balances[asset.id!]!=null?"\$${assetController.balances[asset.id!]!.balanceInFiat.toStringAsFixed(2)}":"\$0.00",
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w400,
              fontSize: 4.sp,
              align: TextAlign.start,
              maxLines: 3,
            ),
          ),
        );
      },
    );
  }
}
