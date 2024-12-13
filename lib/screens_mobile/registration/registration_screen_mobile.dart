import 'dart:developer';
import 'dart:io';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/arrow_back/arrow_back.dart';
import 'package:bunker/screens/admin/controller/admin_controller.dart';
import 'package:bunker/screens/registration/controller/registration_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../components/button/MyButton.dart';
import '../../components/dialogs/my_dialog.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
import '../../routes/AppRoutes.dart';
import '../../user/controller/user_controller.dart';
import '../../user/model/user_crendential.dart';
import '../../utils/my_local_storage.dart';
import '../../utils/size_utils.dart';

class RegistrationScreenMobile extends StatefulWidget {
  RegistrationScreenMobile({super.key});

  @override
  State<RegistrationScreenMobile> createState() => _RegistrationScreenMobileState();
}

class _RegistrationScreenMobileState extends State<RegistrationScreenMobile> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

  String? phoneNumber;

  String? countryCode;

  ValueNotifier<bool> formValidation=ValueNotifier(false);

  final _formKey= GlobalKey<FormState>();

  late UserController userController;

  late AdminController adminController;

  ValueNotifier<bool> agreement=ValueNotifier<bool>(false);

  ValueNotifier<bool> over18=ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    adminController=Provider.of<AdminController>(context,listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary_color,
      appBar: AppBar(
          backgroundColor: secondary_color,
          elevation: SizeUtils.getSize(context, 10.sp),
          centerTitle: false,
          leading: ArrowBack()
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        child: Form(
          key: _formKey,
          onChanged: (){
            formValidation.value=_formKey.currentState!.validate();
          },
          child: Consumer<RegistrationController>(
              builder: (context,rtc,_) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: "Enter email",
                          color: primary_text_color.withOpacity(0.8),
                          weight: FontWeight.w400,
                          fontSize: SizeUtils.getSize(context, 3.sp),
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height:SizeUtils.getSize(context, 2.sp),),
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
                        validator: (val)=>!EmailValidator.validate(val!)?"Enter valid email":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: "Phone number",
                          color: primary_text_color.withOpacity(0.8),
                          weight: FontWeight.w400,
                          fontSize: SizeUtils.getSize(context, 3.sp),
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      IntlPhoneField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        showDropdownIcon: false,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            color: primary_text_color,
                            fontSize: SizeUtils.getSize(context, 4.sp)
                        ),
                        dropdownIconPosition: IconPosition.trailing,
                        dropdownTextStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: SizeUtils.getSize(context, 4.sp)
                        ),
                        pickerDialogStyle: PickerDialogStyle(
                            width: width*0.3,
                            countryCodeStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                color: Colors.white60,
                                fontSize: SizeUtils.getSize(context, 3.sp)
                            ),
                            countryNameStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                color: Colors.white60,
                                fontSize: SizeUtils.getSize(context, 3.sp)
                            ),
                            listTileDivider: const SizedBox(),
                            backgroundColor: primary_color,
                            searchFieldCursorColor: primary_text_color,
                            searchFieldInputDecoration: textFieldDecoration.copyWith(
                              hintText: "Search",
                              fillColor: secondary_bg_color.withOpacity(0.5),
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: SizeUtils.getSize(context, 4.sp)
                              ),
                            )
                        ),
                        decoration: InputDecoration(
                          fillColor: primary_color,
                          filled: true,
                          hoverColor: action_button_color.withOpacity(0.3),
                          contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp), vertical: 0),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, 2.sp))),
                            borderSide: BorderSide(
                              color: primary_color_button,
                              width: 0.2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, 2.sp))),
                            borderSide: BorderSide(
                              color: action_button_color,
                              width: 0.2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          print(phone.number);
                          print(phone.countryCode);
                          countryCode=phone.countryCode;
                          phoneNumber=phone.number;
                        },
                        validator: (val){
                          if(val!.number.isEmpty){
                            log("fddsfsdf");
                            return "Enter phone number";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: "Password",
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
                        style: GoogleFonts.roboto(
                          fontSize: SizeUtils.getSize(context, 4.sp),
                          color: primary_text_color,
                          fontWeight: FontWeight.w300,
                        ),
                        inputDecoration: textFieldDecoration.copyWith(
                            errorMaxLines: 1,
                            errorStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                color: Colors.orangeAccent.withOpacity(0.8),
                                fontSize: SizeUtils.getSize(context, 2.sp)
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp), vertical: 0),
                            hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                color: primary_text_color.withOpacity(0.4),
                                fontSize: SizeUtils.getSize(context, 3.sp)
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  if(rtc.isPassObscured){
                                    rtc.changeObscuredStatus(false);
                                  }else{
                                    rtc.changeObscuredStatus(true);
                                  }
                                },
                                child: Icon(
                                  rtc.isPassObscured?Icons.visibility:Icons.visibility_off,
                                  color: primary_icon_color,
                                )
                            )
                        ),
                        hintText: "Enter your password",
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
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
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
                          valueListenable: agreement,
                          builder: (context,value,_) {
                            return SizedBox(
                              width: width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: value,
                                      checkColor: primary_color_button,
                                      fillColor: MaterialStateProperty.resolveWith((states) => primary_color),
                                      side: BorderSide(
                                          color: primary_color_button
                                      ),
                                      onChanged: (val){
                                        agreement.value=val!;
                                      }
                                  ),
                                  SizedBox(
                                    child: MyText(
                                      text: "Terms and conditions",
                                      color: primary_text_color,
                                      weight: FontWeight.w400,
                                      fontSize: SizeUtils.getSize(context, 3.sp),
                                      align: TextAlign.start,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                      ValueListenableBuilder(
                          valueListenable: over18,
                          builder: (context,value,_) {
                            return SizedBox(
                              width: width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: value,
                                      checkColor: primary_color_button,
                                      fillColor: MaterialStateProperty.resolveWith((states) => primary_color),
                                      side: BorderSide(
                                          color: primary_color_button
                                      ),
                                      onChanged: (val){
                                        over18.value=val!;
                                      }
                                  ),
                                  SizedBox(
                                    child: MyText(
                                      text: "Over 18",
                                      color: primary_text_color,
                                      weight: FontWeight.w400,
                                      fontSize: SizeUtils.getSize(context, 3.sp),
                                      align: TextAlign.start,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      ValueListenableBuilder(
                          valueListenable: formValidation,
                          builder: (context,value,_) {
                            return  ValueListenableBuilder(
                                valueListenable: agreement,
                                builder: (context,isAgree,_) {
                                  return ValueListenableBuilder(
                                      valueListenable: over18,
                                      builder: (context,isOver18,_) {
                                        return MyButton(
                                          text: "Sign up",
                                          borderColor: value&&isAgree&&isOver18?primary_color_button:secondary_color,
                                          bgColor: value&&isAgree&&isOver18?primary_color_button:secondary_color,
                                          txtColor: value&&isAgree&&isOver18?primary_text_color:primary_color_button,
                                          verticalPadding: buttonVerticalPadding,
                                          width: width,
                                          onPressed: ()async{
                                            if(_formKey.currentState!.validate()&&value&&isAgree&&isOver18&&phoneNumber!=null&&countryCode!=null){
                                              await context.push(AppRoutes.loadingScreen, extra: {
                                                'callBack':signUp,
                                                'message': 'Please wait'
                                              });
                                            }
                                          },
                                        );
                                      }
                                  );
                                }
                            );
                          }
                      )
                    ],
                  ),
                );
              }
          ),
        )
      ),
    );
  }

  Future<void> signUp(BuildContext context)async{
    try{
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      UserCredential credential=await userController.signUp(email: email,password: password,phoneNo: phoneNumber!, countryCode: countryCode!);
      await MyLocalStorage().setToken(credential.token!);
      // context.go(AppRoutes.home);
      await MyDialog.showDialog(context: context, message: "An activation link has been sent to your email, click the link to activate your account", icon: Icons.info_outline, iconColor: Colors.green);
      context.go(AppRoutes.emailSent);
    }catch(e){
      context.pop();
      await MyDialog.showDialog(context: context, message: e.toString().replaceAll("Exception:", ""), icon: Icons.info_outline, iconColor: Colors.red);
      throw Exception(e);
    }
  }
}
