import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_component.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
// import 'dart:html' as html;

class EmailSentMobile extends StatelessWidget {
  const EmailSentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){
                  // html.window.close();
                },
                icon: Icon(
                  Icons.close,
                  size: SizeUtils.getSize(context, 8.sp),
                  color: primary_icon_color,
                )
            ),
          ],
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: SizeUtils.getSize(context, 4.sp),),
              SvgPicture.asset(
                "assets/svgs/email_sent.svg",
                width: SizeUtils.getSize(context, 50.sp),
                height: SizeUtils.getSize(context, 40.sp),
              ),
              SizedBox(height: SizeUtils.getSize(context, 4.sp),),
              SizedBox(
                width: width*0.5,
                child: MyText(
                  text: "We have sent you an email, please check your inbox for the activation link, if you don't see the email, please check your spam folder. Thank you!",
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 3.sp),
                  align: TextAlign.center,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
