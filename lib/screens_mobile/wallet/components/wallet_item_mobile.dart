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
import '../../../utils/size_utils.dart';


class WalletItemMobile extends StatelessWidget {
  WalletItemMobile({super.key,required this.asset,required this.callback});
  AssetModel asset;
  Function callback;
  late AssetController assetController;
  @override
  Widget build(BuildContext context) {
    assetController=Provider.of<AssetController>(context,listen: false);
    return Consumer<WalletController>(
      builder: (context, walletCtr, child) {
        return Material(
          borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
          color: Colors.transparent,
          child: ListTile(
            hoverColor: action_button_color.withOpacity(0.3),
            tileColor: walletCtr.selectedIndex==assetController.supportedCoin.indexOf(asset)?secondary_color.withOpacity(0.8):Colors.transparent,
            contentPadding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 1.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
            onTap: (){
              callback.call();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            leading: SizedBox(
              width: SizeUtils.getSize(context, 5.sp),
              height: SizeUtils.getSize(context, 5.sp),
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
                    width: SizeUtils.getSize(context, 5.sp),
                    height: SizeUtils.getSize(context, 5.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, cornerRadius))),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                    width: SizeUtils.getSize(context, 5.sp),
                    height: SizeUtils.getSize(context, 5.sp),
                    child: Icon(Icons.error,size: SizeUtils.getSize(context, 5.sp),)
                ),
              ),
            ),
            title: MyText(
              text: asset.symbol!,
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w400,
              fontSize: SizeUtils.getSize(context, 4.sp),
              align: TextAlign.start,
              maxLines: 3,
            ),
            subtitle: MyText(
              text: "\$${asset.fiatQuotes!.toStringAsFixed(2)}",
              color: primary_text_color.withOpacity(0.6),
              weight: FontWeight.w300,
              fontSize: SizeUtils.getSize(context, 3.sp),
              align: TextAlign.start,
              maxLines: 3,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: assetController.balances[asset.id!]!=null?"\$${assetController.balances[asset.id!]!.balanceInFiat.toStringAsFixed(2)}":"\$0.00",
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 3.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: asset.cryptoBalance!.toStringAsFixed(5),
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 3.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
