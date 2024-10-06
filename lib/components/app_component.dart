import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double height=1.sh;
double width=1.sw;
double pagePadding=8.sp;
double buttonVerticalPadding=5.sp;
double cornerRadius=4.sp;
double textFieldRadius=10.sp;
Color primary_color= Color(0xFF0E131D);
Color secondary_color= Color(0xff161B29);
Color secondary_bg_color=Colors.grey[100]??Colors.grey;

////////////////////////////////////BUTTON////////////////////////////////////
Color primary_color_button= Color(0xff16AAF7);
Color secondary_color_button= Color(0xffEBF1FF);
////////////////////////////////////BUTTON////////////////////////////////////

Color primary_text_color=Colors.white;
Color secondary_text_color=Color(0xff0F0D1A);
Color action_button_color=Color(0xff1D293B);


////////////////////////////////////BORDER////////////////////////////////////
Color primary_border_color=Color(0xff1C171F);
Color secondary_border_color=Colors.white;
Color divider_color=Color(0xFF0EAEA);
////////////////////////////////////BORDER////////////////////////////////////

// ////////////////////////////////BOTTOM SHEET////////////////////////////////////
// Color? primary_bottom_sheet_color=Colors.grey[100];
// Color? bottom_sheet_color=Colors.grey[100];
// ////////////////////////////////////BOTTOM SHEET////////////////////////////////////




////////////////////////////////////ICON////////////////////////////////////
Color primary_icon_color=Color(0xFF141729).withOpacity(0.5);
Color secondary_icon_color=Colors.white;
////////////////////////////////////ICON////////////////////////////////////



final InputDecoration textFieldDecoration=InputDecoration(
  fillColor: primary_color,
  filled: true,
  hoverColor: secondary_color,
  hintStyle: GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    color: primary_text_color.withOpacity(0.4),
    fontSize: 3.sp
  ),

  contentPadding: EdgeInsets.all(2.sp),
  focusedBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: BorderSide(
        color: action_button_color,
      width: 0.2,
    ),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: BorderSide(
      color: action_button_color,
      width: 0.2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.orangeAccent.withOpacity(0.6),
      width: 0.1,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: BorderSide(
      color: action_button_color,
      width: 0.2,
    ),
  ),
  errorStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      color: Colors.orangeAccent.withOpacity(0.8),
      fontSize: 3.sp
  ),
  prefixStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: secondary_text_color,
  ),
);

final InputDecoration amountField=InputDecoration(
  fillColor: primary_color,
  filled: true,
  hoverColor: Colors.white60,
  hintStyle: GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    color: primary_text_color.withOpacity(0.4),
      fontSize: 3.sp
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.orangeAccent.withOpacity(0.6),
        width: 0.1
    ),
  ),
  contentPadding: EdgeInsets.all(8.sp),
  focusedBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0.2
    ),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0.2
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.sp)),
    borderSide: const BorderSide(
        color: Colors.transparent,
        width: 0.2
    ),
  ),
  errorStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.normal,
      color: Colors.orangeAccent.withOpacity(0.6),
      fontSize: 4.sp
  ),
  prefixStyle: GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    color: secondary_text_color,
  ),
);


