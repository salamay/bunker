import 'package:bunker/components/button/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/app_component.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
import 'controller/home_controller.dart';

class UpdateProfileDialog extends StatelessWidget {
  UpdateProfileDialog({super.key});
  late HomeController homeController;

  @override
  Widget build(BuildContext context) {
    homeController=Provider.of<HomeController>(context,listen: false);

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: (){
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  size: SizeUtils.getSize(context, 8.sp),
                  color: primary_icon_color,
                )
            ),
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          SvgPicture.asset(
            "assets/svgs/update_profile.svg",
            width: SizeUtils.getSize(context, 50.sp),
            height: SizeUtils.getSize(context, 40.sp),
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          SizedBox(
            width: width*0.3,
            child: MyText(
              text: "You are welcome to secure ledger, continue to update your profile to enjoy full benefits of our platform",
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w300,
              fontSize: SizeUtils.getSize(context, 3.sp),
              align: TextAlign.center,
              maxLines: 3,
            ),
          ),
          SizedBox(height: SizeUtils.getSize(context, 2.sp),),
          MyButton(
              text: "Continue",
              borderColor: primary_color_button,
              bgColor: primary_color_button,
              txtColor: primary_text_color,
              verticalPadding: buttonVerticalPadding,
              bgRadius: SizeUtils.getSize(context, 2.sp),
              width: width,
              onPressed: (){
                homeController.changePage(1);
                context.pop();
              }
              )
        ],
      ),
    );
  }
}
