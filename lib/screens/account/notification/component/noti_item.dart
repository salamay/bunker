import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/app_component.dart';
import '../../../../components/texts/MyText.dart';
import '../../../../utils/size_utils.dart';
class NotiItem extends StatelessWidget {
  NotiItem({super.key, required this.title, required this.description});
  String title;
  String description;
  ValueNotifier<bool> isActive=ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: MyText(
          text: title,
          color: primary_text_color,
          weight: FontWeight.w400,
          fontSize: SizeUtils.getSize(context, 4.sp),
          align: TextAlign.start,
          maxLines: 1,
        ),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp)),
          child: MyText(
            text: description,
            color: primary_text_color.withOpacity(0.6),
            weight: FontWeight.w300,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
