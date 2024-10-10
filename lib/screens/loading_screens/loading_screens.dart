import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_component.dart';
import '../../components/loading.dart';
import '../../components/texts/MyText.dart';


class LoadingScreen extends StatefulWidget {
  LoadingScreen({required this.message,required this.callBack,super.key});
  Function(BuildContext context) callBack;
  String message;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      widget.callBack(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: "${widget.message}...",
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: 4.sp,
                maxLines: 2,
                align: TextAlign.start,
              ),
              SizedBox(height: 2.sp,),
              Loading(size: 15.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
