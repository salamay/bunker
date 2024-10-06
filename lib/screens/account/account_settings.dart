import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/account/general_settings.dart';
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
    pageController=TabController(length: 1, vsync: this);
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
                builder: (context,stakingType,_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
      
                    ],
                  );
                }
            ),
            SizedBox(height: 8.sp,),
            TabBar(
              controller: pageController,
              dividerHeight: 0.1.sp,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: primary_color_button,
              dividerColor: divider_color.withOpacity(0.1),
              tabs: [
                GestureDetector(
                onTap:(){
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
              ],
            ),
            SizedBox(height: 8.sp,),
            Expanded(
              child: TabBarView(
                controller: pageController,
                children: [
                  GeneralSettings()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
