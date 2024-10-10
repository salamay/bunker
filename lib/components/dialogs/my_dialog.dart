import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_component.dart';
import '../texts/MyText.dart';

class MyDialog{
  static Future<void> showDialog({required BuildContext context,required String message,required IconData icon,required Color iconColor})async{
    await showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: primary_color,
              content: Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 8.sp,
                      color: iconColor,
                    ),
                    SizedBox(height: 4.sp,),
                    MyText(
                        text: message,
                        color: primary_text_color,
                        weight: FontWeight.w500,
                        fontSize: 6.sp,
                        maxLines: 3,
                        align: TextAlign.start
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}