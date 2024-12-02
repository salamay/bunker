import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/loading.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
import '../home/components/my_icon_button.dart';
import '../home/components/top_row.dart';
import 'model/otp_args.dart';


class OtpScreen extends StatefulWidget {
  OtpScreen({required this.otpArgs});
  OtpArgs otpArgs;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final textController=TextEditingController();
  late final OtpArgs otpArgs;
  ValueNotifier<bool> completionNotifier=ValueNotifier(false);
  ValueNotifier<String> pinNotifier=ValueNotifier("");
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpArgs=widget.otpArgs;
    initCallBack();
  }
  void initCallBack()async{
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.otpArgs.initialCallBack.call();
    });
  }
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Loading(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primary_color,
        appBar: AppBar(
            backgroundColor: secondary_color,
            elevation: SizeUtils.getSize(context, 10.sp),
            centerTitle: false,
            title: Row(
              children: [
                TopRow(),
                const Spacer(),
                GestureDetector(
                    onTap: (){
                      context.pop();
                    },
                    child: MyIconButton(text: "Back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
                ),
              ],
            )
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(SizeUtils.getSize(context, 10.sp)),
          child: Center(
            child: SizedBox(
              width: width*0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                      text: "Enter verification code",
                      color: primary_text_color,
                      weight: FontWeight.w800,
                      fontSize: SizeUtils.getSize(context, 8.sp),
                      align: TextAlign.center
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                          text: "Sent code to ",
                          color: primary_text_color,
                          weight: FontWeight.normal,
                          fontSize: SizeUtils.getSize(context, 4.sp),
                          align: TextAlign.center
                      ),
                      MyText(
                          text: "${otpArgs.email.substring(0,1)}***@${otpArgs.email.split("@")[1]}",
                          color: primary_text_color.withOpacity(0.5),
                          weight: FontWeight.bold,
                          fontSize: SizeUtils.getSize(context, 3.sp),
                          align: TextAlign.center
                      ),
                    ],
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  Align(
                    alignment: Alignment.center,
                    child: Pinput(
                      showCursor: true,
                      autofocus: true,
                      length: 6,
                      separator: SizedBox(width: SizeUtils.getSize(context, 4.sp),),
                      controller: textController,
                      defaultPinTheme: PinTheme(
                        width: SizeUtils.getSize(context, 12.sp),
                        height: SizeUtils.getSize(context, 12.sp),
                        textStyle: TextStyle(
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            color: primary_text_color.withOpacity(0.7),
                            fontWeight: FontWeight.w600
                        ),
                        decoration: BoxDecoration(
                          color: primary_color,
                          border: Border.all(
                            color: divider_color.withOpacity(0.6),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 6.sp)),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: SizeUtils.getSize(context, 13.sp),
                        height: SizeUtils.getSize(context, 13.sp),
                        textStyle: TextStyle(
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            color: primary_text_color,
                            fontWeight: FontWeight.w600
                        ),
                        decoration: BoxDecoration(
                          color: primary_color,
                          border: Border.all(
                            color: divider_color.withOpacity(0.6),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 6.sp)),
                        ),
                      ),
                      onChanged: (pin){
                        log(pin);
                        completionNotifier.value=false;
                      },
                      onTapOutside: (event){
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onSubmitted: (pin){
                        log("submitted: $pin");
                        completionNotifier.value=true;
                      },
                      onCompleted: (pin){
                        log("Completed: $pin");
                        pinNotifier.value=pin;
                        completionNotifier.value=true;
                        done(context,true);
                      },
                    ),
                  ),
                  // SizedBox(height: 20.sp,),
                  // GestureDetector(
                  //   onTap: ()async{
                  //     if(context.mounted){
                  //       context.loaderOverlay.show();
                  //       try{
                  //
                  //       }catch(e){
                  //         log(e.toString());
                  //       }
                  //       context.loaderOverlay.hide();
                  //     }
                  //   },
                  //   child: Row(
                  //     children: [
                  //       MyText(
                  //           text: "Resend",
                  //           color: Colors.green,
                  //           weight: FontWeight.w600,
                  //           fontSize: 12.sp,
                  //           align: TextAlign.center
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Spacer(),
                  // ValueListenableBuilder(
                  //   valueListenable: completionNotifier,
                  //   builder: (context,status,_) {
                  //     return Align(
                  //       alignment: Alignment.center,
                  //       child: MyButton(
                  //         text: "Done",
                  //         borderColor: status?primary_color_button:primary_color_button.withOpacity(0.5),
                  //         bgColor: status?primary_color_button:primary_color_button.withOpacity(0.5),
                  //         txtColor: primary_text_color,
                  //         width: width,
                  //         verticalPadding: SizeUtils.getSize(context, buttonVerticalPadding),
                  //         onPressed: ()async{
                  //           done(status);
                  //         },
                  //       ),
                  //     );
                  //   }
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void done(BuildContext context,bool status){
    if(status){
      String pin=pinNotifier.value;
      context.pop(pin);
    }
  }
}
