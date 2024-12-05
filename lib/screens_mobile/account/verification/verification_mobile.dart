import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/button/MyButton.dart';
import 'package:bunker/components/divider.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/account/verification/components/2faModal.dart';
import 'package:bunker/screens/account/verification/kyc_modal.dart';
import 'package:bunker/screens/account/verification/utils/verification_utils.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../components/texts/MyText.dart';
import '../../../screens/account/controller/account_setting_controller.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../../utils/size_utils.dart';

class VerificationMobile extends StatefulWidget {
  VerificationMobile({super.key});

  @override
  State<VerificationMobile> createState() => _VerificationMobileState();
}

class _VerificationMobileState extends State<VerificationMobile> {
  ValueNotifier<int> stepNotifier=ValueNotifier(0);
  late AccountSettingController accountSettingController;
  late UserController userController;
  ValueNotifier<bool> isExpanded=ValueNotifier(false);
  final ExpandedTileController _controller=ExpandedTileController(isExpanded:false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountSettingController = Provider.of<AccountSettingController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((time){
      ProfileModel? profileModel = accountSettingController.profileModel;
      if(profileModel!=null){
        if(profileModel.basicDetailsUpdated==true){
          stepNotifier.value=1;
        }
        if(profileModel.is2FaEnabled!){
          stepNotifier.value=2;
        }
        if(profileModel.kycEnabled==true){
          stepNotifier.value=3;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        child: SingleChildScrollView(
          child: Consumer<AccountSettingController>(
            builder: (context,accountCtr,_) {
              ProfileModel? profileModel = accountSettingController.profileModel;
              if(profileModel!=null){
                WidgetsBinding.instance.addPostFrameCallback((time){
                  log(profileModel.is2FaEnabled!.toString());
                  if(profileModel.basicDetailsUpdated==true){
                    stepNotifier.value=1;
                  }
                  if(profileModel.is2FaEnabled!){
                    stepNotifier.value=2;
                  }
                  if(profileModel.kycEnabled==true){
                    stepNotifier.value=3;
                  }
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Verification",
                    color: primary_text_color,
                    weight: FontWeight.w400,
                    fontSize: SizeUtils.getSize(context, 4.sp),
                    align: TextAlign.start,
                    maxLines: 1,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                  MyText(
                    text: "Verify your account with KYC to unlock all features",
                    color: primary_text_color,
                    weight: FontWeight.w300,
                    fontSize: SizeUtils.getSize(context, 3.sp),
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  MyDivider(),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  ValueListenableBuilder(
                      valueListenable: stepNotifier,
                      builder: (context,activeStep,child){
                        log("Active step: $activeStep");
                        return EasyStepper(
                          lineStyle: LineStyle(
                              lineLength: width*0.2,
                              finishedLineColor: Colors.green,
                              activeLineColor: Colors.orange,
                              lineThickness: 0.4
                          ),
                          stepRadius: SizeUtils.getSize(context, 5.sp),
                          activeStep: activeStep,
                          enableStepTapping: false,
                          stepBorderRadius: SizeUtils.getSize(context, 5.sp),
                          activeStepTextColor: primary_text_color,
                          finishedStepTextColor: primary_text_color,
                          finishedStepBackgroundColor: Colors.green.withOpacity(0.4),
                          unreachedStepBackgroundColor: Colors.orange.withOpacity(0.4),
                          activeStepBackgroundColor: Colors.green,
                          activeStepBorderColor: Colors.green,
                          // showLoadingAnimation: true,
                          loadingAnimation: "assets/lotties/loading_white.json",
                          showStepBorder: true,
                          steps: [
                            EasyStep(
                                topTitle:false,
                                finishIcon: Icon(
                                  Icons.task_alt,
                                  color: Colors.green,
                                  size: SizeUtils.getSize(context, 6.sp),
                                ),
                                customStep: Icon(
                                  Icons.task_alt,
                                  color: activeStep >= 1 ? Colors.green : Colors.orange,
                                  size: SizeUtils.getSize(context, 6.sp),
                                ),
                                title: "Basic details",
                            ),
                            EasyStep(
                                topTitle:false,
                              finishIcon: Icon(
                                Icons.security,
                                color: Colors.green,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                                customStep: Icon(
                                  Icons.security,
                                  color: activeStep >= 2 ? Colors.green : Colors.orange,
                                  size: SizeUtils.getSize(context, 6.sp),
                                ),
                                title: "Multi-factor authentication",
                            ),
                            EasyStep(
                              topTitle:false,
                              finishIcon: Icon(
                                Icons.task_alt,
                                color: Colors.green,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              customStep: Icon(
                                Icons.task_alt,
                                color: activeStep >= 3 ? Colors.green : Colors.orange,
                                size: SizeUtils.getSize(context, 6.sp),
                              ),
                              title: "KYC",
                            )
                          ],
                          onStepReached: (index) {
                            stepNotifier.value=index;
                          },
                        );
                      }
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  ValueListenableBuilder(
                      valueListenable: stepNotifier,
                      builder: (context,activeStep,child){
                        if(activeStep==1){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: MyText(
                                  text: "Complete Two-Factor Authentication",
                                  color: primary_text_color,
                                  weight: FontWeight.w600,
                                  fontSize: SizeUtils.getSize(context, 6.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                              Align(
                                alignment: Alignment.center,
                                child: MyText(
                                  text: "You must activate two-factor authentication before you can continue.",
                                  color: primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w400,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: width,
                                  child: ValueListenableBuilder(
                                      valueListenable: isExpanded,
                                      builder: (context,expanded,_) {
                                        return ExpandedTile(
                                          theme: ExpandedTileThemeData(
                                              headerColor: Colors.transparent,
                                              headerPadding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
                                              headerSplashColor: primary_color,
                                              contentSeparatorColor: Colors.transparent,
                                              contentBackgroundColor: Colors.transparent,
                                              contentPadding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
                                              leadingPadding: EdgeInsets.all(SizeUtils.getSize(context, 0.sp)),

                                              headerBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 8.sp)),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0.2.sp,
                                                ),
                                              )
                                          ),
                                          controller: _controller,
                                          title: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, buttonVerticalPadding),horizontal: SizeUtils.getSize(context, 8.sp)),
                                                decoration: BoxDecoration(
                                                    color: primary_color_button,
                                                    borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius))
                                                ),
                                                child: MyText(
                                                  text: "Complete Two-Factor Authentication",
                                                  color: primary_text_color.withOpacity(0.8),
                                                  weight: FontWeight.w600,
                                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                                  align: TextAlign.start,
                                                  maxLines: 1,
                                                ),
                                              )
                                          ),
                                          trailing: expanded?Icon(
                                            Icons.keyboard_double_arrow_up,
                                            size: SizeUtils.getSize(context, 6.sp),
                                            color: primary_icon_color,
                                          ):Icon(
                                            Icons.keyboard_double_arrow_down,
                                            size: SizeUtils.getSize(context, 6.sp),
                                            color: primary_icon_color,
                                          ),
                                          content: TwoFaModal(profileModel: profileModel,),
                                          onTap: () {
                                            switch(expanded) {
                                              case true:
                                                isExpanded.value=false;
                                                break;
                                              case false:
                                                isExpanded.value=true;
                                                break;
                                            }
                                          },
                                        );
                                      }
                                  ),
                                ),
                              ),

                            ],
                          );
                        }else if(activeStep==2){
                          return KycModal();
                        }else{
                          return const SizedBox();
                        }

                    }
                  ),

                ],
              );
            }
          ),
        ),
      ),
    );
  }

}
