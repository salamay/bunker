import 'package:bunker/components/arrow_back/arrow_back.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/dialogs/my_dialog.dart';
import '../../components/form/MyFormField.dart';
import '../../components/loading.dart';
import '../../components/texts/MyText.dart';
import '../../screens/registration/controller/registration_controller.dart';
import '../../user/controller/user_controller.dart';
import '../../utils/size_utils.dart';
class SendResetPassEmailMobile extends StatefulWidget {
  SendResetPassEmailMobile({super.key});

  @override
  State<SendResetPassEmailMobile> createState() => _SendResetPassEmailMobileState();
}

class _SendResetPassEmailMobileState extends State<SendResetPassEmailMobile> {
  ValueNotifier<bool> formValidation=ValueNotifier(false);

  final _formKey= GlobalKey<FormState>();

  TextEditingController emailController=TextEditingController();

  late UserController userController;

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
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
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(child: Loading(size: SizeUtils.getSize(context, 10.sp),)),
          overlayOpacity: 0.1,
          child: Form(
            key: _formKey,
            onChanged: (){
              formValidation.value=_formKey.currentState!.validate();
            },
            child: Consumer<RegistrationController>(
                builder: (context,rtc,_) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        SizedBox(height: SizeUtils.getSize(context, 15.sp),),
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
                                    sendLink(context);
                                  }
                                },
                              );
                            }
                        )
                      ]
                  );
                }
            ),
          ),
        )
      ),
    );
  }

  Future<void> sendLink(BuildContext context)async{
    try{
      context.loaderOverlay.show();
      String email=emailController.text.trim();
      await userController.passwordChangeOtp(email: email);
      context.loaderOverlay.hide();
      await MyDialog.showDialog(context: context, message: "Password reset link has been sent to your email", icon: Icons.info_outline, iconColor: Colors.green);
      emailController.clear();
    }catch(e){
      context.loaderOverlay.hide();
      await MyDialog.showDialog(context: context, message: "Unable to send otp", icon: Icons.info_outline, iconColor: Colors.red);
      throw Exception(e);
    }
  }
}
