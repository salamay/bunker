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
      width: w,
      padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 1.sp),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageAsset,
            width: iconSize??6.sp,
            fit: BoxFit.contain,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.sp),
            child: MyText(
              text: text,
              color: primary_text_color,
              weight: FontWeight.w600,
              fontSize: fontSize??6.sp,
              align: TextAlign.start,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
