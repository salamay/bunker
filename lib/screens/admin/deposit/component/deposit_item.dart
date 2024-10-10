import 'package:bunker/components/app_component.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../components/texts/MyText.dart';
class DepositItem extends StatelessWidget {
  DepositItem({super.key,required this.asset,required this.callBack});
  late AssetController assetController;
  AssetModel asset;
  Function callBack;

  @override
  Widget build(BuildContext context) {
    assetController=Provider.of<AssetController>(context,listen: false);
    return Container(
      margin: EdgeInsets.only(bottom: 2.sp),
      child: Material(
        borderRadius: BorderRadius.circular(cornerRadius),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: ListTile(
          hoverColor: action_button_color.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          onTap: (){
            callBack.call();
          },
          leading:  SizedBox(
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
            text: asset.symbol!,
            color: primary_text_color,
            weight: FontWeight.w500,
            fontSize: 4.sp,
            align: TextAlign.start,
            maxLines: 3,
          ),
          subtitle: MyText(
            text: asset.symbol!,
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w400,
            fontSize: 3.sp,
            align: TextAlign.start,
            maxLines: 3,
          ),
          trailing: MyText(
            text: "\$${asset.balance!.toStringAsFixed(2)}",
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w400,
            fontSize: 4.sp,
            align: TextAlign.start,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
