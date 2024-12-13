import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/size_utils.dart';
import '../app_component.dart';
class MyFormField extends StatelessWidget {

  MyFormField({
    required this.controller,
    required this.hintText,
    required this.enable,
    required this.textInputType,
    required this.errorText,
    required this.maxLines,
    required this.obscureText,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.style,
    this.inputDecoration,
    required this.textAlign,
    super.key
  });

  TextEditingController controller;
  String hintText;
  String errorText;
  int? maxLines;
  TextInputType textInputType;
  bool obscureText;
  int? maxLength;
  Function()? onEditingComplete;
  Function (String)? onChanged;
  Function(PointerDownEvent)? onTapOutside;
  Function (String)? onFieldSubmitted;
  String? Function(String?)? validator;
  bool enable;
  Widget? suffixIcon;
  TextStyle? style;
  InputDecoration? inputDecoration;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        textAlign: textAlign,
        enabled: enable,
        maxLength: maxLength,
        controller: controller,
        maxLines: maxLines??1,
        obscureText: obscureText,
        style: style??GoogleFonts.roboto(
          fontSize: SizeUtils.getSize(context, 4.sp),
          color: primary_text_color,
          fontWeight: FontWeight.w300,
        ),
        decoration: inputDecoration??textFieldDecoration.copyWith(
          errorMaxLines: 1, // Limit the error text to one line
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp), vertical: 0),
          hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              color: primary_text_color.withOpacity(0.4),
              fontSize: SizeUtils.getSize(context, 3.sp)
          ),
          errorStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Colors.orangeAccent.withOpacity(0.8),
              fontSize: SizeUtils.getSize(context, 2.sp)
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, 2.sp))),
            borderSide: BorderSide(
              color: primary_color_button,
              width: 0.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, 2.sp))),
            borderSide: BorderSide(
              color: action_button_color,
              width: 0.2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.sp)),
            borderSide: BorderSide(
              color: action_button_color,
              width: 0.2,
            ),
          ),
          prefixStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: secondary_text_color,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        keyboardType: textInputType,
        onChanged: onChanged,
        validator: validator,
        onTapOutside: onTapOutside,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
