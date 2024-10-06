import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_component.dart';
import '../texts/MyText.dart';

class GradientButton extends StatelessWidget {
  GradientButton({required this.text,this.boxWidth,super.key});
  String text;
  double? boxWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      padding: EdgeInsets.symmetric(horizontal: 25.sp,vertical: 8.sp),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      gradient: LinearGradient(
        colors: [
          primary_color_button,
          primary_color_button,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      )
    ),
        child: MyText(
            text: text,
            color: primary_text_color,
            weight: FontWeight.w500,
            fontSize: 14.sp,
            align: TextAlign.start
        )
    );
  }
}
