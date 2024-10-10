import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/empty/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../components/texts/MyText.dart';
import '../home/components/my_icon_button.dart';
class Support extends StatelessWidget {
  Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.sp,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Create ticket",
                color: primary_text_color,
                weight: FontWeight.w600,
                fontSize: 10.sp,
                align: TextAlign.start,
                maxLines: 3,
              ),
              GestureDetector(
                onTap: (){
                  context.push(AppRoutes.createTicket);
                },
                  child: MyIconButton(text: "Create", imageAsset: "assets/svgs/create.svg",color: primary_color_button,)
              ),
            ],
          ),
          SizedBox(height: 4.sp,),
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: secondary_color.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
            ),
            child: EmptyPage(
                title: "Oops! Nothing is here",
                subtitle: "We couldn't find any support tickets. Create a new ticket to get started."
            ),
          )
        ],
      ),
    );
  }
}
