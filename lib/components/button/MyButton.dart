import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_component.dart';
import '../texts/MyText.dart';


class MyButton extends StatelessWidget {
  String text;
  Color bgColor;
  Color? borderColor;
  Color txtColor;
  double? bgRadius;
  double verticalPadding;
  double? width;
  EdgeInsets? margin;
  Function onPressed;
  MyButton({required this.text, required this. bgColor,this.borderColor,required this.txtColor, this.bgRadius,required this.verticalPadding, this.width,this.margin,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed.call();
        },
        style: ButtonStyle(
          elevation:  MaterialStateProperty.resolveWith((states){
            return states.contains(MaterialState.pressed)
                ? 20
                : 0;
          }),
          overlayColor: MaterialStateProperty.resolveWith(
                (states) {
              return states.contains(MaterialState.pressed)
                  ? Colors.grey[100]!.withOpacity(0.3)
                  : null;
            },
          ),
          padding: MaterialStateProperty.resolveWith((states){
            return EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, verticalPadding),horizontal: SizeUtils.getSize(context, verticalPadding));

          }),
          backgroundColor: MaterialStateProperty.resolveWith((states){
            return bgColor;
          }),
          shape: MaterialStateProperty.resolveWith((states){
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(bgRadius??8)),
                side: BorderSide(
                    color: borderColor??primary_color_button,
                    width: 0.2
                )
            );
          }),
        ),
        child:MyText(
            text: text,
            color: txtColor,
            weight: FontWeight.w500,
            fontSize: SizeUtils.getSize(context, 4.sp),
            maxLines: 1,
            align: TextAlign.center
        ),
      ),
    );
  }
}
