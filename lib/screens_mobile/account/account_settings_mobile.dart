import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/account/general_settings.dart';
import 'package:bunker/screens/account/notification/notification_settings.dart';
import 'package:bunker/screens/account/payment_methods/payment_methods.dart';
import 'package:bunker/screens/account/security/security_settings.dart';
import 'package:bunker/screens/account/verification/verification.dart';
import 'package:bunker/screens_mobile/account/payment_methods/payment_methods.dart';
import 'package:bunker/screens_mobile/account/security/security_settings.dart';
import 'package:bunker/screens_mobile/account/verification/verification_mobile.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/texts/MyText.dart';
import '../../screens/account/controller/account_setting_controller.dart';
import 'general_settings_mobile.dart';
import 'notification/notification_settings_mobile.dart';

class AccountSettingsMobile extends StatefulWidget {
  AccountSettingsMobile({super.key});

  @override
  State<AccountSettingsMobile> createState() => _AccountSettingsMobileState();
}

class _AccountSettingsMobileState extends State<AccountSettingsMobile> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  late TabController pageController;
  ValueNotifier<SettingType> settingTypeNotifier=ValueNotifier(SettingType.general);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=TabController(length: 5,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context); // Necessary for `AutomaticKeepAliveClientMixin`
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8.sp),
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.sp,),
            MyText(
              text: "Account Settings",
              color: primary_text_color,
              weight: FontWeight.w600,
              fontSize: SizeUtils.getSize(context, 6.sp),
              align: TextAlign.start,
              maxLines: 3,
            ),
            SizedBox(height: SizeUtils.getSize(context, 8.sp),),
            SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: ValueListenableBuilder(
                    valueListenable: settingTypeNotifier,
                    builder: (context,settingType,_) {
                      return TabBar(
                        controller: pageController,
                        dividerHeight: 0.1.sp,
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorColor: primary_color_button,
                        dividerColor: divider_color.withOpacity(0.1),
                        onTap: (index){
                          switch(index){
                            case 0:
                              settingTypeNotifier.value=SettingType.general;
                              pageController.animateTo(0);
                              break;
                            case 1:
                              settingTypeNotifier.value=SettingType.notification;
                              pageController.animateTo(1);
                              break;
                            case 2:
                              settingTypeNotifier.value=SettingType.verification;
                              pageController.animateTo(2);
                              break;
                            case 3:
                              settingTypeNotifier.value=SettingType.security;
                              pageController.animateTo(3);
                              break;
                            case 4:
                              settingTypeNotifier.value=SettingType.payment;
                              pageController.animateTo(4);
                              break;
                          }
                        },
                        tabs: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: settingType==SettingType.general?primary_color_button:primary_text_color.withOpacity(0.5),
                                size: SizeUtils.getSize(context, 6.sp)
                              ),
                              SizedBox(width: 1.sp,),
                              MyText(
                                  text: "General",
                                  color: settingType==SettingType.general?primary_color_button:primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.notification_add_outlined,
                                  color: settingType==SettingType.notification?primary_color_button:primary_text_color.withOpacity(0.5),
                                  size: SizeUtils.getSize(context, 6.sp)
                              ),
                              SizedBox(width: 1.sp,),
                              MyText(
                                  text: "Notifications",
                                  color: settingType==SettingType.notification?primary_color_button:primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.verified_user_outlined,
                                  color: settingType==SettingType.verification?primary_color_button:primary_text_color.withOpacity(0.5),
                                  size: SizeUtils.getSize(context, 6.sp)
                              ),
                              SizedBox(width: 1.sp,),
                              MyText(
                                  text: "Verification",
                                  color: settingType==SettingType.verification?primary_color_button:primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.security_outlined,
                                  color: settingType==SettingType.security?primary_color_button:primary_text_color.withOpacity(0.5),
                                  size: SizeUtils.getSize(context, 6.sp)
                              ),
                              SizedBox(width: 1.sp,),
                              MyText(
                                  text: "Security",
                                  color: settingType==SettingType.security?primary_color_button:primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.payment_outlined,
                                  color: settingType==SettingType.payment?primary_color_button:primary_text_color.withOpacity(0.5),
                                  size: SizeUtils.getSize(context, 6.sp)
                              ),
                              SizedBox(width: 1.sp,),
                              MyText(
                                  text: "Payment methods",
                                  color: settingType==SettingType.payment?primary_color_button:primary_text_color.withOpacity(0.8),
                                  weight: FontWeight.w300,
                                  fontSize: SizeUtils.getSize(context, 4.sp),
                                  align: TextAlign.center
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),
            SizedBox(height: 8.sp,),
            Expanded(
              child: TabBarView(
                controller: pageController,
                children: [
                  GeneralSettingsMobile(),
                  NotificationSettingsMobile(),
                  VerificationMobile(),
                  SecuritySettingsMobile(),
                  PaymentMethodsMobile()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;  // Keeps the widget alive
}
