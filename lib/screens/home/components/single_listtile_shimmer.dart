import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../utils/size_utils.dart';
class SingleListTileShimmer extends StatelessWidget {
  const SingleListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        text: "You can add or remove your payment methods here",
        color: primary_text_color.withOpacity(0.8),
        weight: FontWeight.w400,
        fontSize: SizeUtils.getSize(context, 4.sp),
        align: TextAlign.start,
        maxLines: 3,
      ),
      subtitle: MyText(
        text: "You can add or remove \nyour payment methods here",
        color: primary_text_color.withOpacity(0.8),
        weight: FontWeight.w400,
        fontSize: SizeUtils.getSize(context, 4.sp),
        align: TextAlign.start,
        maxLines: 3,
      ),
    );
  }
}
