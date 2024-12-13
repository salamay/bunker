import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/dialogs/my_dialog.dart';
import 'package:bunker/components/snackbar/show_snack_bar.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/button/MyButton.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
import '../../utils/my_local_storage.dart';
import '../../utils/size_utils.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey= GlobalKey<FormState>();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  ValueNotifier<bool> formValidation=ValueNotifier(false);

  late UserController userController;

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: height,
        width: width,
        child: Container(
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bg_image.jpg",
                  ),
                fit: BoxFit.cover,
                opacity: 0.5
              ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: height,
                  padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Welcome to Secure Ledger",
                        color: primary_text_color,
                        weight: FontWeight.w600,
                        fontSize: SizeUtils.getSize(context, 8.sp),
                        align: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyText(
                        text: "The all in one wallet for all your crypto needs",
                        color: primary_text_color.withOpacity(0.5),
                        weight: FontWeight.w300,
                        fontSize: SizeUtils.getSize(context, 3.sp),
                        align: TextAlign.start,
                        maxLines: 3,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          "assets/lotties/welocme.json",
                          width: SizeUtils.getSize(context, 150.sp),
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    height: height,
                    padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 20.sp),horizontal: SizeUtils.getSize(context, 10.sp)),
                    decoration: BoxDecoration(
                      color: primary_color,
                    ),
                    child: Form(
                      key: _formKey,
                      onChanged: (){
                        if(_formKey.currentState!.validate()){
                          formValidation.value=true;
                        }else{
                          formValidation.value=false;
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Secure Ledger",
                            color: primary_color_button,
                            weight: FontWeight.w600,
                            fontSize: SizeUtils.getSize(context, 8.sp),
                            align: TextAlign.center,
                            maxLines: 1,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                          MyText(
                            text: "Sign in",
                            color: primary_text_color,
                            weight: FontWeight.w500,
                            fontSize: SizeUtils.getSize(context, 6.sp),
                            align: TextAlign.center,
                            maxLines: 1,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: "Don't have an account?",
                                color: primary_text_color,
                                weight: FontWeight.w300,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                                align: TextAlign.start,
                                maxLines: 3,
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.push(AppRoutes.registration);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                                  child: MyText(
                                    text: "Create",
                                    color: primary_color_button.withOpacity(0.8),
                                    weight: FontWeight.w700,
                                    fontSize: SizeUtils.getSize(context, 4.sp),
                                    align: TextAlign.start,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 10.sp),),
                          MyFormField(
                            controller: emailController,
                            textAlign: TextAlign.start,
                            hintText: "Email address",
                            enable: true,
                            textInputType: TextInputType.emailAddress,
                            errorText: "Invalid email",
                            maxLines: 1,
                            obscureText: false,
                            onEditingComplete: () {

                            },
                            onFieldSubmitted: null,
                            validator: (val)=>!EmailValidator.validate(val!)?"Please provide your email":null,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                          MyFormField(
                            controller: passwordController,
                            textAlign: TextAlign.start,
                            hintText: "Password",
                            enable: true,
                            textInputType: TextInputType.text,
                            errorText: "Invalid password",
                            maxLines: 1,
                            obscureText: false,
                            onEditingComplete: () {

                            },
                            onFieldSubmitted: null,
                            validator: (val)=>val!.isEmpty?"Invalid":null,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 10.sp),),
                          ValueListenableBuilder(
                              valueListenable: formValidation,
                              builder: (context,value,_) {
                                return MyButton(
                                  text: "Sign in",
                                  borderColor: value?primary_color_button:secondary_color,
                                  bgColor: value?primary_color_button:secondary_color,
                                  txtColor: value?primary_text_color:primary_color_button,
                                  verticalPadding: buttonVerticalPadding,
                                  bgRadius: SizeUtils.getSize(context, cornerRadius),
                                  width: width,
                                  onPressed: ()async{
                                    if(_formKey.currentState!.validate()){
                                      String email=emailController.text.trim();
                                      String password=passwordController.text.trim();
                                      if(_formKey.currentState!.validate()){
                                        context.push(AppRoutes.loadingScreen, extra: {
                                          'callBack':signIn,
                                          'message': 'Restoring wallet'
                                        });
                                      }
                                      // SendPayload payload=widget.sendPayload.copyWith(recipient_address: address);
                                      // context.push(AppRoutes.reviewTransaction,extra: payload);
                                    }
                                  },
                                );
                              }
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: "Forgot password?",
                                color: primary_text_color,
                                weight: FontWeight.w300,
                                fontSize: SizeUtils.getSize(context, 3.sp),
                                align: TextAlign.start,
                                maxLines: 3,
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.push(AppRoutes.sendResetPassEmail);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                                  child: MyText(
                                    text: "Reset",
                                    color: primary_color_button.withOpacity(0.8),
                                    weight: FontWeight.w700,
                                    fontSize: SizeUtils.getSize(context, 4.sp),
                                    align: TextAlign.start,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context)async{
    try{
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      UserCredential credential=await userController.signIn(email: email,password: password);
      await MyLocalStorage().setToken(credential.token!);
      context.go(AppRoutes.home);
    }catch(e){
      log(e.toString());
      context.pop();
      await MyDialog.showDialog(context: context, message: e.toString().replaceAll("Exception:", ""), icon: Icons.info_outline, iconColor: Colors.red);
    }
  }
}
