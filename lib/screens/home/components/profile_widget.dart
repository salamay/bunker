import 'package:bunker/components/app_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/texts/MyText.dart';
class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key, required this.email});
  String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.sp,horizontal: 4.sp),
      decoration: BoxDecoration(
        color: primary_color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 8.sp,
                backgroundColor: action_button_color,
                child: MyText(
                  text: email[0].toUpperCase(),
                  color: primary_text_color.withOpacity(0.4),
                  weight: FontWeight.w600,
                  fontSize: 5.sp,
                  align: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              Positioned(
                bottom: 2.sp,
                right: 0.sp,
                child: Container(
                  width: 3.sp,
                  height: 3.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                text: email,
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: 3.sp,
                align: TextAlign.start,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
