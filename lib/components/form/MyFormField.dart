import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          fontSize: 4.sp,
          color: primary_text_color,
          fontWeight: FontWeight.w400,
        ),
        decoration: inputDecoration??textFieldDecoration.copyWith(
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon??SizedBox(),
            ],
          ),
        ),
        keyboardType: textInputType,
        validator: validator,
        onTapOutside: onTapOutside,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
