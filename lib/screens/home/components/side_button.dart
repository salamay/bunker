import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../components/app_component.dart";
import "../../../components/texts/MyText.dart";


class SideButton extends StatefulWidget {
  SideButton({super.key, required this.text, required this.imageAsset});
  String text;
  String imageAsset;


  @override
  State<SideButton> createState() => _SideButtonState();
}

class _SideButtonState extends State<SideButton> {
  Color _buttonColor = secondary_color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _buttonColor = action_button_color.withOpacity(0.3)),
      onExit: (event) => setState(() => _buttonColor = secondary_color),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.sp,horizontal: 4.sp),
        decoration: BoxDecoration(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(2.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  widget.imageAsset,
                  width: 8.sp,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                text: widget.text,
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: 3.sp,
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
