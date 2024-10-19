import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
class MyIconButton extends StatelessWidget {
  MyIconButton({super.key, required this.text, required this.imageAsset,required this.color,this.fontSize,this.iconSize,this.w});
  String text;
  String imageAsset;
  double? fontSize;
  double?iconSize;
  double? w;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp), vertical: SizeUtils.getSize(context, 1.sp)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imageAsset,
            width: iconSize??SizeUtils.getSize(context, 2.sp),
            fit: BoxFit.contain,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 4.sp)),
            child: MyText(
              text: text,
              color: primary_text_color,
              weight: FontWeight.w600,
              fontSize: fontSize??SizeUtils.getSize(context, 3.sp,),
              align: TextAlign.start,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
