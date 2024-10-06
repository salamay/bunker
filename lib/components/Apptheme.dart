import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_component.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: primary_color,
      dialogBackgroundColor: primary_color,
      dialogTheme: DialogTheme(
      backgroundColor: primary_color,

    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.openSans(
        color: primary_color_button,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),

      backgroundColor: primary_color,
      surfaceTintColor: primary_color,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white60,
      filled: true,
      hoverColor: Colors.white60,
      hintStyle: GoogleFonts.lato(
        fontWeight: FontWeight.normal,
        color: primary_color_button,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        borderSide: BorderSide(
            color: primary_color_button,
            width: 0.2
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        borderSide: BorderSide(
          color: primary_color_button,
          width: 0.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:  BorderSide(
          color: primary_color_button,
          width: 0.2,
        ),
      )
    )
  );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: primary_color,
      dialogBackgroundColor: primary_color,
      dialogTheme: DialogTheme(
        backgroundColor: primary_color,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.openSans(
            color: primary_color_button,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp
        ),
        backgroundColor: primary_color,
        surfaceTintColor: primary_color,
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white60,
          filled: true,
          hoverColor: Colors.grey,
          hintStyle: GoogleFonts.lato(
            fontWeight: FontWeight.normal,
            color: secondary_text_color,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
            borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
            borderSide: const  BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:  BorderSide(
              color: Colors.amber,
              width: 0.2,
            ),
          )
      )
  );
}