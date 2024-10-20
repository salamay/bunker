import 'dart:developer';

import 'package:bunker/components/button/MyButton.dart';
import 'package:bunker/screens/support/controller/support_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../components/app_component.dart';
import '../../../components/loading.dart';
import '../../../components/snackbar/show_snack_bar.dart';
import '../../../components/texts/MyText.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../../utils/size_utils.dart';
import '../controller/account_setting_controller.dart';
import '../model/profile_model.dart';

class KycModal extends StatefulWidget {
  KycModal({super.key});

  @override
  State<KycModal> createState() => _KycModalState();
}

class _KycModalState extends State<KycModal> {

  late AccountSettingController accountSettingController;
  late SupportController supportController;
  late UserController userController;
  final ImagePicker picker = ImagePicker();
  ValueNotifier<XFile?> imageNotifier=ValueNotifier(null);

  ValueNotifier<bool> confirmingNotifier=ValueNotifier(false);

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountSettingController = Provider.of<AccountSettingController>(context, listen: false);
    supportController = Provider.of<SupportController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: Consumer<AccountSettingController>(
          builder: (context,accountCtr,_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(cornerRadius),
                    border: Border.all(color: primary_color_button,width: 0.1.sp)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Selfie Photo",
                      color: primary_text_color,
                      weight: FontWeight.w600,
                      fontSize: SizeUtils.getSize(context, 4.sp),
                      align: TextAlign.center,
                      maxLines: 1,
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                    MyText(
                      text: "Please upload a selfie of yourself holding your ID or Drivers License",
                      color: primary_text_color.withOpacity(0.8),
                      weight: FontWeight.w400,
                      fontSize: SizeUtils.getSize(context, 3.sp),
                      align: TextAlign.center,
                      maxLines: 3,
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                    GestureDetector(
                      onTap: ()async{
                        if(kIsWeb){
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          if(image!=null){
                            log("Image: ${image.path}");
                            imageNotifier.value=image;
                          }
                        }
                      },
                      child: Container(
                        width: width*0.3,
                        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
                        decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(cornerRadius),
                              border: Border.all(color: secondary_border_color,width: 0.1.sp)
                          ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.drive_folder_upload_rounded,
                              color: primary_color_button,
                              size: SizeUtils.getSize(context, 6.sp),
                            ),
                            SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                            MyText(
                              text: "Upload",
                              color: primary_color_button,
                              weight: FontWeight.w600,
                              fontSize: SizeUtils.getSize(context, 4.sp),
                              align: TextAlign.center,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                    ValueListenableBuilder(
                        valueListenable: imageNotifier,
                        builder: (context,imagePath,_) {
                          return GestureDetector(
                            onTap: (){
                              imageNotifier.value=null;
                            },
                            child: MyText(
                              text: imagePath!=null?imagePath.path:"",
                              color: primary_text_color.withOpacity(0.6),
                              weight: FontWeight.w300,
                              fontSize: SizeUtils.getSize(context, 2.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          );
                        }
                    ),

                  ],
                ),
              ),
              SizedBox(height: SizeUtils.getSize(context, 2.sp),),
              MyText(
                text: "Please allow up to 24 hours for your KYC verification to be processed",
                color: primary_text_color.withOpacity(0.6),
                weight: FontWeight.w300,
                fontSize: SizeUtils.getSize(context, 4.sp),
                align: TextAlign.start,
                maxLines: 3,
              ),
              SizedBox(height: SizeUtils.getSize(context, 2.sp),),
              ValueListenableBuilder(
                  valueListenable: confirmingNotifier,
                  builder: (context,isConfirming,_) {
                  return !isConfirming?MyButton(
                    text: "Confirm",
                    borderColor: primary_color_button,
                    bgColor: primary_color_button,
                    txtColor: primary_text_color,
                    verticalPadding: buttonVerticalPadding,
                    bgRadius: SizeUtils.getSize(context, cornerRadius),
                    width: width*0.3,
                    onPressed: ()async{
                      try{
                        UserCredential? credential=userController.userCredential;
                        if(credential!=null){
                          confirmingNotifier.value=true;
                          String imageUrl="";
                          if(imageNotifier.value!=null){
                            var bytes=await imageNotifier.value!.readAsBytes();
                            imageUrl=await supportController.uploadImage(credential: credential, bytes: bytes);
                            await updateProfile(isKyc: true,imageUrl: imageUrl);
                            ShowSnackBar.show(context, "Submitted",Colors.greenAccent);

                          }
                          confirmingNotifier.value=false;
                        }
                      }catch(e){
                        log(e.toString());
                        ShowSnackBar.show(context, "Unable to complete kyc", Colors.red);
                        confirmingNotifier.value=false;
                      }
                    },
                  ):Loading(
                    size: SizeUtils.getSize(context, buttonVerticalPadding+SizeUtils.getSize(context, 4.sp)),
                  );
                }
              )
            ],
          );
        }
      ),
    );
  }
  Future<void> updateProfile({required bool isKyc,required imageUrl})async {
    UserCredential? credential = userController.userCredential;
    if (credential != null) {
      try {
        ProfileModel profile = accountSettingController.profileModel!;
        profile.kycEnabled = isKyc;
        profile.imageUrl = imageUrl;
        await accountSettingController.updateProfile(credential: credential, profile: profile);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
