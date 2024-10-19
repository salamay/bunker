import 'package:bunker/components/app_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/texts/MyText.dart';
import '../../../utils/size_utils.dart';

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 4.sp)),
              color: secondary_color,
            ),
            child: Image.asset(
              "assets/boorio.png",
              width: SizeUtils.getSize(context, 20.sp),
              fit: BoxFit.contain,
            ),
          ),
          MyText(
            text: "Private wallet",
            color: primary_color_button.withOpacity(0.3),
            weight: FontWeight.w700,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
        ],
      )
    );
  }
}
