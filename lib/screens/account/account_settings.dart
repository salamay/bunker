import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/account/general_settings.dart';
import 'package:bunker/screens/account/notification/notification_settings.dart';
import 'package:bunker/screens/account/payment_methods/payment_methods.dart';
import 'package:bunker/screens/account/security/security_settings.dart';
import 'package:bunker/screens/account/verification/verification.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/texts/MyText.dart';
import 'controller/account_setting_controller.dart';
class AccountSettings extends StatefulWidget {
  AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> with SingleTickerProviderStateMixin{
  late TabController pageController;
  ValueNotifier<SettingType> settingTypeNotifier=ValueNotifier(SettingType.general);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=TabController(length: 5, initialIndex: 4,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
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
              fontSize: 10.sp,
              align: TextAlign.start,
              maxLines: 3,
            ),
            SizedBox(height: 10.sp,),
            ValueListenableBuilder(
                valueListenable: settingTypeNotifier,
                builder: (context,settingType,_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: pageController,
                        dividerHeight: 0.1.sp,
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorColor: settingType==SettingType.notification?primary_color_button:Colors.transparent,
                        dividerColor: divider_color.withOpacity(0.1),
                        tabs: [
                          GestureDetector(
                            onTap:(){
                              settingTypeNotifier.value=SettingType.notification;
                              pageController.animateTo(0);
                            },
                            child: MyText(
                                text: "General",
                                color: primary_text_color.withOpacity(0.5),
                                weight: FontWeight.w400,
                                fontSize: 4.sp,
                                align: TextAlign.center
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              pageController.animateTo(1);
                              settingTypeNotifier.value=SettingType.notification;
                            },
                            child: MyText(
                                text: "Notifications",
                                color: primary_text_color.withOpacity(0.5),
                                weight: FontWeight.w400,
                                fontSize: 4.sp,
                                align: TextAlign.center
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              pageController.animateTo(2);
                              settingTypeNotifier.value=SettingType.notification;
                            },
                            child: MyText(
                                text: "Verification",
                                color: primary_text_color.withOpacity(0.5),
                                weight: FontWeight.w400,
                                fontSize: 4.sp,
                                align: TextAlign.center
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              pageController.animateTo(3);
                              settingTypeNotifier.value=SettingType.security;
                            },
                            child: MyText(
                                text: "Security",
                                color: primary_text_color.withOpacity(0.5),
                                weight: FontWeight.w400,
                                fontSize: 4.sp,
                                align: TextAlign.center
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              pageController.animateTo(4);
                              settingTypeNotifier.value=SettingType.payment;
                            },
                            child: MyText(
                                text: "Payment methods",
                                color: primary_text_color.withOpacity(0.5),
                                weight: FontWeight.w400,
                                fontSize: 4.sp,
                                align: TextAlign.center
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            ),
            SizedBox(height: 8.sp,),
            Expanded(
              child: TabBarView(
                controller: pageController,
                children: [
                  GeneralSettings(),
                  Expanded(child: NotificationSettings()),
                  Expanded(child: Verification()),
                  Expanded(child: SecuritySettings()),
                  Expanded(child: PaymentMethods())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
