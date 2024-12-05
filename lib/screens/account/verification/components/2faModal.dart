import 'dart:developer';

import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../components/app_component.dart';
import '../../../../components/button/MyButton.dart';
import '../../../../components/texts/MyText.dart';
import '../../../../user/controller/user_controller.dart';
import '../../../../user/model/user_crendential.dart';
import '../../../../utils/size_utils.dart';
import '../../controller/account_setting_controller.dart';
import '../utils/verification_utils.dart';
class TwoFaModal extends StatelessWidget {
  TwoFaModal({super.key,required this.profileModel});
  ProfileModel? profileModel;
  late AccountSettingController accountSettingController;
  late UserController userController;

  @override
  Widget build(BuildContext context) {
    accountSettingController = Provider.of<AccountSettingController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(color: secondary_border_color,width: 0.1.sp)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
              text: "Security",
              color: primary_text_color,
              weight: FontWeight.w500,
              fontSize: SizeUtils.getSize(context,4.sp),
              align: TextAlign.start
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              profileModel!=null?Container(
                height: SizeUtils.getSize(context, 2.sp),
                width: SizeUtils.getSize(context, 2.sp),
                decoration: BoxDecoration(
                    color: profileModel!.is2FaEnabled!?Colors.green:Colors.red,
                    shape: BoxShape.circle
                ),
              ):const SizedBox(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                child: profileModel!=null?MyText(
                    text: profileModel!.is2FaEnabled!?"ON":"OFF",
                    color: profileModel!.is2FaEnabled!?Colors.green:Colors.red,
                    weight: FontWeight.w500,
                    fontSize: SizeUtils.getSize(context,4.sp),
                    align: TextAlign.start
                ):MyText(
                    text: "Off",
                    color: Colors.red,
                    weight: FontWeight.w500,
                    fontSize: SizeUtils.getSize(context,4.sp),
                    align: TextAlign.start
                ),
              )
            ],
          ),
          SizedBox(height: SizeUtils.getSize(context, 2.sp),),
          MyText(
            text: "Authenticator app",
            color: primary_text_color,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 4.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
          SizedBox(height: SizeUtils.getSize(context, 1.sp),),
          MyText(
            text: "Use an authenticator to generate one time codes",
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          profileModel!=null?MyButton(
            text: profileModel!.is2FaEnabled!?"Deactivate":"Activate",
            borderColor: primary_color_button,
            bgColor: Colors.transparent,
            txtColor: primary_text_color,
            verticalPadding: buttonVerticalPadding,
            bgRadius: 2.sp,
            width: width,
            onPressed: ()async{
              if(profileModel!.is2FaEnabled==true){
                update(is2fa: false);
              }else{
                if(SizeUtils.isMobileView(context)){
                  bool? result=await VerificationUtils.show2FADialogMobile(context: context);
                  log("Result: $result");
                  if(result!=null){
                    if(result){
                      update(is2fa: true);
                    }
                  }
                }else{
                  bool? result=await VerificationUtils.show2FADialog(context: context);
                  log("Result: $result");
                  if(result!=null){
                    if(result){
                      update(is2fa: true);
                    }
                  }
                }

              }
            },
          ):const SizedBox()
        ],
      ),
    );
  }
  Future<void> update({required bool is2fa})async {
    UserCredential? credential = userController.userCredential;
    if (credential != null) {
      try {
        ProfileModel profile = accountSettingController.profileModel!;
        profile.is2FaEnabled = is2fa;
        await accountSettingController.updateProfile(credential: credential, profile: profile);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
