import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/admin/controller/admin_controller.dart';
import 'package:bunker/screens/registration/controller/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../components/button/MyButton.dart';
import '../../components/dialogs/my_dialog.dart';
import '../../components/form/MyFormField.dart';
import '../../components/loading.dart';
import '../../components/texts/MyText.dart';
import '../../routes/AppRoutes.dart';
import '../../user/controller/user_controller.dart';
import '../../utils/size_utils.dart';
import '../home/components/my_icon_button.dart';
import '../home/components/top_row.dart';
import '../otp_screen/model/otp_args.dart';
class ResetPassword extends StatefulWidget {
  ResetPassword({super.key,required this.code,required this.email});
  String code;
  String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  ValueNotifier<bool> formValidation=ValueNotifier(false);

  final _formKey= GlobalKey<FormState>();

  late UserController userController;

  late AdminController adminController;

  @override
  Widget build(BuildContext context) {
    log(widget.code);
    log(widget.email);
    userController=Provider.of<UserController>(context,listen: false);
    adminController=Provider.of<AdminController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Loading(size: SizeUtils.getSize(context, 10.sp),),
      overlayOpacity: 0.1,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primary_color,
        appBar: AppBar(
            backgroundColor: secondary_color,
            elevation: SizeUtils.getSize(context, 10.sp),
            centerTitle: false,
            title: const Row(
              children: [
                TopRow(),
              ],
            )
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
          child: Center(
            child: SizedBox(
              width: width*0.3,
              child: Form(
                key: _formKey,
                onChanged: (){
                  formValidation.value=_formKey.currentState!.validate();
                },
                child: Consumer<RegistrationController>(
                    builder: (context,rtc,_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: "New password",
                              color: primary_text_color.withOpacity(0.8),
                              weight: FontWeight.w400,
                              fontSize: SizeUtils.getSize(context, 3.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height:SizeUtils.getSize(context, 2.sp),),
                          MyFormField(
                            controller: passwordController,
                            textAlign: TextAlign.start,
                            inputDecoration: textFieldDecoration.copyWith(
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      if(rtc.isPassObscured){
                                        rtc.changeObscuredStatus(false);
                                      }else{
                                        rtc.changeObscuredStatus(true);
                                      }
                                    },
                                    icon: Icon(
                                      rtc.isPassObscured?Icons.visibility:Icons.visibility_off,
                                      color: primary_icon_color,
                                    )
                                )
                            ),
                            hintText: "Enter new password",
                            enable: true,
                            textInputType: TextInputType.text,
                            errorText: "Invalid password",
                            maxLines: 1,
                            obscureText: rtc.isPassObscured,
                            onEditingComplete: null,
                            onFieldSubmitted: null,
                            onTapOutside: (event){
                              FocusScope.of(context).unfocus();
                            },
                            validator: (val) {
                              if (rtc.eightCharacters &&
                                  rtc.containsLowercase &&
                                  rtc.containsUpperCase &&
                                  rtc.containsNumber &&
                                  rtc.containSymbol) {
                                return null;
                              } else {
                                return "Invalid password";
                              }
                            },
                            onChanged: (val){
                              rtc.checkInput(val.trim());
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: "Confirm password",
                              color: primary_text_color.withOpacity(0.8),
                              weight: FontWeight.w400,
                              fontSize: SizeUtils.getSize(context, 3.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height:SizeUtils.getSize(context, 2.sp),),
                          MyFormField(
                            controller: confirmPasswordController,
                            textAlign: TextAlign.start,
                            hintText: "Confirm",
                            enable: true,
                            textInputType: TextInputType.text,
                            errorText: "Passwords do not match",
                            maxLines: 1,
                            obscureText: rtc.isPassObscured,
                            onEditingComplete: null,
                            onFieldSubmitted: null,
                            onTapOutside: (event){
                              FocusScope.of(context).unfocus();
                            },
                            validator: (val) {
                              if (val!.trim() == passwordController.text.trim()) {
                                return null;
                              } else {
                                return "Passwords do not match";
                              }
                            },
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: "Password should contain",
                              color: primary_text_color,
                              weight: FontWeight.w500,
                              align: TextAlign.start,
                              maxLines: 1,
                              fontSize: SizeUtils.getSize(context, 4.sp),
                            ),
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                rtc.containsLowercase
                                    ? Icons.done
                                    : Icons.close,
                                color: rtc.containsLowercase
                                    ? Colors.green
                                    : Colors.redAccent,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              SizedBox(
                                width: SizeUtils.getSize(context, 2.sp),
                              ),
                              MyText(
                                text: "Contains lowercase",
                                color: rtc.containsLowercase
                                    ? Colors.green
                                    : primary_text_color.withOpacity(0.5),
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 1,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                rtc.containsUpperCase
                                    ? Icons.done
                                    : Icons.close,
                                color: rtc.containsUpperCase
                                    ? Colors.green
                                    : Colors.redAccent,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              SizedBox(
                                width: SizeUtils.getSize(context, 2.sp),
                              ),
                              MyText(
                                text: "Contains uppercase",
                                color: rtc.containsUpperCase
                                    ? Colors.green
                                    : primary_text_color.withOpacity(0.5),
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 1,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                rtc.containsNumber ? Icons.done : Icons.close,
                                color:
                                rtc.containsNumber ? Colors.green : Colors.redAccent,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              SizedBox(
                                width: SizeUtils.getSize(context, 2.sp),
                              ),
                              MyText(
                                text: "Contains a number",
                                color: rtc.containsNumber
                                    ? Colors.green
                                    : primary_text_color.withOpacity(0.5),
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 1,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                rtc.containSymbol ? Icons.done : Icons.close,
                                color:
                                rtc.containSymbol ? Colors.green : Colors.redAccent,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              SizedBox(
                                width: SizeUtils.getSize(context, 2.sp),
                              ),
                              MyText(
                                text: "Contains a symbol",
                                color: rtc.containSymbol
                                    ? Colors.green
                                    : primary_icon_color.withOpacity(0.5),
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 1,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.getSize(context, 2.sp),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                rtc.eightCharacters ? Icons.done : Icons.close,
                                color:
                                rtc.eightCharacters ? Colors.green : Colors.redAccent,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              SizedBox(
                                width: SizeUtils.getSize(context, 2.sp),
                              ),
                              MyText(
                                text: "Be at least 8 characters long",
                                color: rtc.eightCharacters
                                    ? Colors.green
                                    : primary_text_color.withOpacity(0.5),
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 1,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                          ValueListenableBuilder(
                              valueListenable: formValidation,
                              builder: (context,value,_) {
                                return MyButton(
                                    text: "Reset password",
                                  borderColor: value?primary_color_button:secondary_color,
                                  bgColor: value?primary_color_button:secondary_color,
                                  txtColor: value?primary_text_color:primary_color_button,
                                  verticalPadding: buttonVerticalPadding,
                                  width: width,
                                  onPressed: ()async{
                                    if(_formKey.currentState!.validate()){
                                        await resetPassword(context, widget.code);

                                    }
                                  },
                                );
                              }
                          )
                        ],
                      );
                    }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendOtp(BuildContext context)async{
    try{
      String email=widget.email;
      String code=widget.code;
      await userController.passwordChangeOtp(email: email);
    }catch(e){
      await MyDialog.showDialog(context: context, message: "Unable to send otp", icon: Icons.info_outline, iconColor: Colors.red);
      throw Exception(e);
    }
  }

  Future<void> resetPassword(BuildContext context,String pin)async{
    try{
      context.loaderOverlay.show();
      String email=widget.email;
      String password=passwordController.text.trim();
      await userController.passwordChange(email: email, newPassword: password, otp: pin);
      await MyDialog.showDialog(context: context, message: "Your password has been reset", icon: Icons.info_outline, iconColor: Colors.green);
      passwordController.clear();
      context.loaderOverlay.hide();
      context.push(AppRoutes.welcome);
    }catch( e){
      context.loaderOverlay.hide();
      await MyDialog.showDialog(context: context, message: e.toString(), icon: Icons.info_outline, iconColor: Colors.red);
      throw Exception(e);
    }
  }
}
