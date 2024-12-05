import 'package:bunker/components/app_component.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/texts/MyText.dart';
class ViewDesktop extends StatelessWidget {
  const ViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svgs/desktop_mode.svg",
            height: height * 0.2,
            width: width*0.5,
          ),
          SizedBox(height: SizeUtils.getSize(context, 8.sp),),
          SizedBox(
            width: width*0.7,
            child: MyText(
              text: "Please view this page on a desktop or a bigger screen",
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w400,
              fontSize: SizeUtils.getSize(context, 4.sp),
              align: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
