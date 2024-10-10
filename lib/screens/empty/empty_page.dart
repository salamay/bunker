import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_component.dart';
import '../../components/texts/MyText.dart';
class EmptyPage extends StatelessWidget {
  EmptyPage({super.key,required this.title,required this.subtitle});
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svgs/empty.svg",
            width: 50.sp,
            color: primary_icon_color.withOpacity(0.2),
            height: 50.sp,
          ),
          SizedBox(height: 2.sp,),
          MyText(
            text: title,
            color: primary_text_color.withOpacity(0.4),
            weight: FontWeight.w600,
            fontSize: 8.sp,
            align: TextAlign.start,
            maxLines: 3,
          ),
          SizedBox(height: 2.sp,),
          MyText(
            text: subtitle,
            color: primary_text_color.withOpacity(0.2),
            weight: FontWeight.w400,
            fontSize: 6.sp,
            align: TextAlign.start,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
