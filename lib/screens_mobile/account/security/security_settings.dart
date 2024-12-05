import 'package:bunker/components/loading.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/home/components/listtile_shimmer.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../screens/account/controller/account_setting_controller.dart';
import '../../../screens/account/verification/components/2faModal.dart';

class SecuritySettingsMobile extends StatelessWidget {
  const SecuritySettingsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        decoration: BoxDecoration(
          color: secondary_color,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: SingleChildScrollView(
          child: Consumer<AccountSettingController>(
              builder: (context,accountCtr,_) {
                ProfileModel? profileModel=accountCtr.profileModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Login history",
                    color: primary_text_color,
                    weight: FontWeight.w400,
                    fontSize: SizeUtils.getSize(context, 4.sp),
                    align: TextAlign.start,
                    maxLines: 1,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                  MyText(
                    text: "Your recent login activity",
                    color: primary_text_color.withOpacity(0.8),
                    weight: FontWeight.w400,
                    fontSize: SizeUtils.getSize(context, 3.sp),
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 2.sp)),
                    decoration: BoxDecoration(
                      color: secondary_color,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: MyText(
                            text: "TYPE",
                            color: primary_text_color.withOpacity(0.8),
                            weight: FontWeight.w400,
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            align: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: MyText(
                            text: "IP ADDRESS",
                            color: primary_text_color.withOpacity(0.8),
                            weight: FontWeight.w400,
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            align: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: MyText(
                            text: "DEVICE",
                            color: primary_text_color.withOpacity(0.8),
                            weight: FontWeight.w400,
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            align: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                  Skeletonizer(
                    ignoreContainers: false,
                    enabled: accountCtr.authHistoryLoading,
                    enableSwitchAnimation: true,
                    effect: ShimmerEffect(
                        duration: const Duration(milliseconds: 1000),
                        baseColor: secondary_color.withOpacity(0.6),
                        highlightColor: action_button_color.withOpacity(0.8)
                    ),
                    child: !accountCtr.authHistoryLoading?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: accountCtr.loginHistory.map((e){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 4.sp),horizontal: SizeUtils.getSize(context, 2.sp)),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: MyText(
                                  text: "Authentication\n${e.loginTime.toString()}",
                                  color: primary_text_color,
                                  weight: FontWeight.w400,
                                  fontSize: SizeUtils.getSize(context, 3.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: MyText(
                                  text: e.ipAddress!,
                                  color: primary_text_color,
                                  weight: FontWeight.w400,
                                  fontSize: SizeUtils.getSize(context, 3.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: MyText(
                                  text: e.device!,
                                  color: primary_text_color,
                                  weight: FontWeight.w400,
                                  fontSize: SizeUtils.getSize(context, 3.sp),
                                  align: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),

                            ],
                          ),
                        );
                      }).toList(),
                    ):const ListTileShimmer(),
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  SizedBox(
                    width: width*0.5,
                      child: TwoFaModal(profileModel: profileModel,)
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
