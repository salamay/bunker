import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../app_component.dart';
class ArrowBack extends StatelessWidget {
  ArrowBack({this.icon,super.key});
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pop();
      },
      child: Padding(
        padding:  EdgeInsets.all(SizeUtils.getSize(context, 4.sp)),
        child: Icon(
          icon??Icons.arrow_back_ios_new,
          color: primary_icon_color,
          size: 18.sp,
        ),
      ),
    );
  }
}
