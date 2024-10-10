import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar/top_snackbar.dart';

class ShowSnackBar{

  static void show(BuildContext context,String message,Color color){
    CustomTopSnackbar.show(
      context,
       message,
      // Customize more additional properties as required (optional)
      leadingIcon: Icons.info,
      textSizeFactor: 0.009,
      backgroundColor: color,
      borderColor: color,
      topPadding: 2.sp,
    );
  }
}