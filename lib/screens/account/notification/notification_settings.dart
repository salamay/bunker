import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/account/notification/component/noti_item.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../components/texts/MyText.dart';
import '../../../user/model/user_crendential.dart';

class NotificationSettings extends StatefulWidget {
  NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  ValueNotifier<bool> isTxReceived = ValueNotifier(false);
  ValueNotifier<bool> isTxSent = ValueNotifier(false);
  late AccountSettingController accountSettingController;
  late UserController userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountSettingController = Provider.of<AccountSettingController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileModel? profileModel = accountSettingController.profileModel;
      if(profileModel!=null){
        isTxReceived.value = profileModel.isTxReceived??false;
        isTxSent.value = profileModel.isTxSent??false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp), horizontal: SizeUtils.getSize(context, 4.sp)),
      decoration: BoxDecoration(
          color: secondary_color,
          borderRadius: BorderRadius.circular(cornerRadius)
      ),
      child: Consumer<AccountSettingController>(
        builder: (context, accountCtr, child) {
          ProfileModel? profileModel= accountCtr.profileModel;
          if(profileModel!=null){
            isTxReceived.value = profileModel.isTxReceived??false;
            isTxSent.value = profileModel.isTxSent??false;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: MyText(
                      text: "Email Notifications",
                      color: primary_text_color,
                      weight: FontWeight.w600,
                      fontSize: SizeUtils.getSize(context, 4.sp),
                      align: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: NotiItem(
                                  title: "Transaction Received",
                                  description: "Receive an email when transactions is received"
                              ),
                            ),
                            const Spacer(),
                            ValueListenableBuilder(
                                valueListenable: isTxReceived,
                                builder: (context, isReceived, _) {
                                  return Switch(
                                    inactiveTrackColor: primary_color,
                                    activeTrackColor: primary_color_button,
                                    value: isReceived,
                                    onChanged: (value) async {
                                      isTxReceived.value = value;
                                      update();
                                    },
                                  );
                                }
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: NotiItem(
                                    title: "Transaction Sent",
                                    description: "Receive an email when transactions is sent"
                                )
                            ),
                            const Spacer(),
                            ValueListenableBuilder(
                                valueListenable: isTxSent,
                                builder: (context, isSent, _) {
                                  return Switch(
                                    inactiveTrackColor: primary_color,
                                    activeTrackColor: primary_color_button,
                                    value: isSent,
                                    onChanged: (value) async {
                                      isTxSent.value = value;
                                      update();
                                    },
                                  );
                                }
                            ),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  Future<void> update()async {
    UserCredential? credential = userController.userCredential;
    if (credential != null) {
      try {
        ProfileModel profile = accountSettingController.profileModel!;
        profile.isTxReceived = isTxReceived.value;
        profile.isTxSent = isTxSent.value;
        await accountSettingController.updateProfile(credential: credential, profile: profile);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
