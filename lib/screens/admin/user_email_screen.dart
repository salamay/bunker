import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/admin/controller/admin_controller.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/button/MyButton.dart';
import '../../components/dialogs/my_dialog.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
import '../../routes/AppRoutes.dart';
import '../../user/controller/user_controller.dart';
import '../../utils/size_utils.dart';
import '../home/components/my_icon_button.dart';
import '../home/components/top_row.dart';
class UserEmailScreen extends StatelessWidget {
  UserEmailScreen({super.key});

  TextEditingController emailController=TextEditingController();
  ValueNotifier<bool> formValidation=ValueNotifier(false);
  final _formKey= GlobalKey<FormState>();
  late UserController userController;
  late AdminController adminController;

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
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        child: Center(

          child: SizedBox(
            width: width*0.25,
            child: Form(
              key: _formKey,
              onChanged: (){
                formValidation.value=_formKey.currentState!.validate();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: "Enter user email",
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
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  ValueListenableBuilder(
                      valueListenable: formValidation,
                      builder: (context,value,_) {
                        return MyButton(
                          text: "Continue",
                          borderColor: value?primary_color_button:secondary_color,
                          bgColor: value?primary_color_button:secondary_color,
                          txtColor: value?primary_text_color:primary_color_button,
                          verticalPadding: buttonVerticalPadding,
                          width: width,
                          onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              String email=emailController.text.trim();
                              if(_formKey.currentState!.validate()){
                                context.push(AppRoutes.loadingScreen, extra: {
                                  'callBack':getWallet,
                                  'message': 'Please wait'
                                });
                              }

                            }
                          },
                        );
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> getWallet(BuildContext context)async{
    try{
      UserCredential? credential=userController.userCredential;
      if(credential!=null){
        String email=emailController.text.trim();
        List<AssetModel> assets=await adminController.getUserWallet(credential: credential, email: email);
        if(assets.isNotEmpty){
          context.pushReplacement(AppRoutes.depositPage, extra: assets);
        }else{
          await MyDialog.showDialog(context: context, message: "An error occurred", icon: Icons.info_outline, iconColor: Colors.red);
          context.pop();

        }
      }
    }catch(e){
      context.pop();
      await MyDialog.showDialog(context: context, message: "Unable to get user assets", icon: Icons.info_outline, iconColor: Colors.red);
      throw Exception(e);
    }
  }
}
