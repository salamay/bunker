import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/theme_controller.dart';

class MyText extends StatelessWidget {
  String text;
  Color color;
  FontWeight weight;
  TextAlign align;
  double? fontSize;
  int? maxLines;
  double? height;
  bool? isUnderline;
  MyText({required this.text,required this.color,required this.weight,required this.align,this.fontSize,this.maxLines,this.isUnderline,this.height,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Text(
          text,
          textAlign: align,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            decoration: isUnderline??false?TextDecoration.underline:TextDecoration.none,
              fontWeight: weight,
              color: color,
              fontSize: fontSize,

          ),
        );
      }
    );
  }
}
