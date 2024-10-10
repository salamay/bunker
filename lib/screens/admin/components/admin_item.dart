import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
class AdminItem extends StatelessWidget {
  AdminItem({super.key,required this.title,required this.imageAsset});
  String title;
  String imageAsset;
  ValueNotifier<Color> _buttonColor=ValueNotifier<Color>(secondary_color.withOpacity(0.3));

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: Colors.transparent,
      child: MouseRegion(
        onEnter: (event){
          _buttonColor.value=action_button_color.withOpacity(0.3);
        },
        onExit: (event){
          _buttonColor.value=secondary_color.withOpacity(0.3);
        },
        child: ValueListenableBuilder(
          valueListenable: _buttonColor,
          builder: (context,color,_) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.sp,vertical: 10.sp),
              width: 80.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                color: color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imageAsset,
                    width: 15.sp,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 2.sp,),
                  MyText(
                    text: title,
                    color: Colors.white,
                    weight: FontWeight.w500,
                    fontSize: 4.sp,
                    align: TextAlign.start,
                    maxLines: 1,
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
