import 'package:bunker/components/app_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../components/button/MyButton.dart';
import '../../components/texts/MyText.dart';
import '../../routes/AppRoutes.dart';
import '../home/components/my_icon_button.dart';
import '../home/components/top_row.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary_color,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/landing_page.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TopRow(),
                const Spacer(),
                MyButton(
                  text: "Get started",
                  borderColor: primary_color_button,
                  bgColor: primary_color_button,
                  txtColor: primary_text_color,
                  verticalPadding: buttonVerticalPadding,
                  width: 40.sp,
                  onPressed: ()async{
                    context.push(AppRoutes.welcome);
                  },
                ),
              ],
            ),
            SizedBox(height: 10.sp,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: MyText(
                          text: "Explore the world of",
                          color: primary_text_color.withOpacity(0.8),
                          weight: FontWeight.w700,
                          fontSize: 14.sp,
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 2.sp,),
                      SizedBox(
                        child: MyText(
                          text: "investment",
                          color: primary_color_button,
                          weight: FontWeight.w700,
                          fontSize: 14.sp,
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 4.sp,),
                      SizedBox(
                        width: width*0.4,
                        child: MyText(
                          text: "A comprehensive platform for admins to manage investments maximizing growth potential and financial security",
                          color: primary_text_color.withOpacity(0.7),
                          weight: FontWeight.w300,
                          fontSize: 6.sp,
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 4.sp,),
                      MyButton(
                        text: "Get started",
                        borderColor: primary_color_button,
                        bgColor: primary_color_button,
                        txtColor: primary_text_color,
                        verticalPadding: buttonVerticalPadding,
                        width: 40.sp,
                        onPressed: ()async{
                          context.push(AppRoutes.welcome);
                        },
                      )
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: width*0.4,
                  child: Image.asset(
                    "assets/device.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
