import 'dart:developer';
import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:otp/otp.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../../components/app_component.dart';
import '../../../../components/button/MyButton.dart';
import '../../../../components/form/MyFormField.dart';
import '../../../../components/snackbar/show_snack_bar.dart';
import '../../../../components/texts/MyText.dart';
import '../../../../utils/my_local_storage.dart';
import '../../../../utils/size_utils.dart';

class VerificationUtils{

  static Future<bool?> show2FADialog({required BuildContext context})async{
    String secret=OTP.randomSecret();
    final _formKey= GlobalKey<FormState>();
    final TextEditingController codeController=TextEditingController();
    bool? result=await showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: primary_color,
              content: Container(
                width: width*0.3,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 6.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: width*0.2,
                              child: MyText(
                                  text: "Scan this code with your preferred, authenticator app",
                                  color: primary_text_color,
                                  weight: FontWeight.w500,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  maxLines: 3,
                                  align: TextAlign.center
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: (){
                                  context.pop();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: SizeUtils.getSize(context, 4.sp),
                                  color: primary_icon_color,
                                )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      Expanded(
                        child: Center(
                          child: PrettyQr(
                            size: SizeUtils.getSize(context, 50.sp),
                            data: "otpauth://totp/Bunker clone?secret=$secret",
                            elementColor: primary_text_color,
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: 4.sp),
                        decoration: BoxDecoration(
                            color: action_button_color,
                            borderRadius: BorderRadius.circular(cornerRadius)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                                text: secret.toUpperCase(),
                                color: primary_text_color,
                                weight: FontWeight.w800,
                                fontSize: SizeUtils.getSize(context, 4.sp),
                                maxLines: 2,
                                align: TextAlign.start
                            ),
                            SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                            IconButton(
                                onPressed: (){
                                  FlutterClipboard.copy(secret).then((value) => log("Copied!"));
                                  ShowSnackBar.show(context, "Copied!",Colors.greenAccent);
                                },
                                icon: Icon(
                                  Icons.copy_rounded,
                                  size: SizeUtils.getSize(context, 4.sp),
                                  color: primary_color_button,
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      MyFormField(
                        controller: codeController,
                        textAlign: TextAlign.start,
                        hintText: "2FA Code",
                        enable: true,
                        textInputType: TextInputType.emailAddress,
                        errorText: "Required",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {
                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Required":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                          text: "Confirm",
                          borderColor: primary_color_button,
                          bgColor: Colors.transparent,
                          txtColor: primary_text_color,
                          verticalPadding: buttonVerticalPadding,
                          bgRadius: 2.sp,
                          width: width,
                          onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              String otp=codeController.text.trim();
                              if(validateOTP(secret, otp)) {
                                await MyLocalStorage().setGoogleAuthSecretKey(secret);
                                await MyLocalStorage().setIsGoogleAuth(true);
                                context.pop(true);
                                ShowSnackBar.show(context, "2FA enabled",Colors.greenAccent);
                              }else{
                                ShowSnackBar.show(context, "Invalid code",Colors.redAccent);
                              }

                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
    return result;
  }

  static Future<bool?> show2FADialogMobile({required BuildContext context})async{
    String secret=OTP.randomSecret();
    final _formKey= GlobalKey<FormState>();
    final TextEditingController codeController=TextEditingController();
    bool? result=await showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: primary_color,
              content: Container(
                width: width*0.8,
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 6.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: width*0.2,
                              child: MyText(
                                  text: "Scan this code with your preferred, authenticator app",
                                  color: primary_text_color,
                                  weight: FontWeight.w500,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  maxLines: 3,
                                  align: TextAlign.center
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: (){
                                  context.pop();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: SizeUtils.getSize(context, 4.sp),
                                  color: primary_icon_color,
                                )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      Center(
                        child: PrettyQr(
                          size: SizeUtils.getSize(context, 50.sp),
                          data: "otpauth://totp/Bunker clone?secret=$secret",
                          elementColor: primary_text_color,
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true,
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: 4.sp),
                        decoration: BoxDecoration(
                            color: action_button_color,
                            borderRadius: BorderRadius.circular(cornerRadius)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                                text: secret.toUpperCase(),
                                color: primary_text_color,
                                weight: FontWeight.w800,
                                fontSize: SizeUtils.getSize(context, 4.sp),
                                maxLines: 2,
                                align: TextAlign.start
                            ),
                            SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                            IconButton(
                                onPressed: (){
                                  FlutterClipboard.copy(secret).then((value) => log("Copied!"));
                                  ShowSnackBar.show(context, "Copied!",Colors.greenAccent);
                                },
                                icon: Icon(
                                  Icons.copy_rounded,
                                  size: SizeUtils.getSize(context, 4.sp),
                                  color: primary_color_button,
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      MyFormField(
                        controller: codeController,
                        textAlign: TextAlign.start,
                        hintText: "2FA Code",
                        enable: true,
                        textInputType: TextInputType.emailAddress,
                        errorText: "Required",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {
                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Required":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                          text: "Confirm",
                          borderColor: primary_color_button,
                          bgColor: Colors.transparent,
                          txtColor: primary_text_color,
                          verticalPadding: buttonVerticalPadding,
                          bgRadius: 2.sp,
                          width: width,
                          onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              String otp=codeController.text.trim();
                              if(validateOTP(secret, otp)) {
                                await MyLocalStorage().setGoogleAuthSecretKey(secret);
                                await MyLocalStorage().setIsGoogleAuth(true);
                                context.pop(true);
                                ShowSnackBar.show(context, "2FA enabled",Colors.greenAccent);
                              }else{
                                ShowSnackBar.show(context, "Invalid code",Colors.redAccent);
                              }

                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
    return result;
  }


  static bool validateOTP(String secret, String code) {
    final totp = OTP.generateTOTPCodeString(secret.toUpperCase(), DateTime.now().millisecondsSinceEpoch,length: 6, interval: 30, algorithm: Algorithm.SHA1, isGoogle: true);
    log("TOTP: $totp");
    return totp == code;
  }
}