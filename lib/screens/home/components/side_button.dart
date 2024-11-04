import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../components/app_component.dart";
import "../../../components/texts/MyText.dart";
import "../../../utils/size_utils.dart";


class SideButton extends StatefulWidget {
  SideButton({super.key, required this.text, required this.imageAsset,required this.selectedColor});
  String text;
  String imageAsset;
  Color selectedColor;


  @override
  State<SideButton> createState() => _SideButtonState();
}

class _SideButtonState extends State<SideButton> {
  Color _buttonColor = secondary_color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _buttonColor = action_button_color),
      onExit: (event) => setState(() => _buttonColor = widget.selectedColor),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 4.sp),vertical: 2.sp),
        decoration: BoxDecoration(
          color: widget.selectedColor,
          borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 2.sp)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.imageAsset,
              width: SizeUtils.getSize(context, 8.sp),
              fit: BoxFit.contain,
              color: primary_color_button.withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 4.sp)),
              child: MyText(
                text: widget.text,
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: SizeUtils.getSize(context, 3.sp),
                align: TextAlign.start,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
