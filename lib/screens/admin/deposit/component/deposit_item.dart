import 'package:bunker/components/app_component.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:bunker/utils/size_utils.dart';
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
      margin: EdgeInsets.only(bottom: SizeUtils.getSize(context, 2.sp)),
      child: Material(
        borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: ListTile(
          hoverColor: action_button_color.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
          ),
          onTap: (){
            callBack.call();
          },
          leading:  SizedBox(
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
                  child: Icon(Icons.error,size: SizeUtils.getSize(context, 8.sp),)
              ),
            ),
          ),
          title: MyText(
            text: asset.symbol!,
            color: primary_text_color,
            weight: FontWeight.w500,
            fontSize: SizeUtils.getSize(context, 4.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
          subtitle: MyText(
            text: asset.symbol!,
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
          trailing: MyText(
            text: "\$${asset.balance!.toStringAsFixed(2)}",
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 4.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
