import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/account/account_settings.dart';
import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/admin/admin.dart';
import 'package:bunker/screens/home/components/profile_widget.dart';
import 'package:bunker/screens/home/components/side_button.dart';
import 'package:bunker/screens/home/components/top_row.dart';
import 'package:bunker/screens/home/controller/home_controller.dart';
import 'package:bunker/screens/overview/overview.dart';
import 'package:bunker/screens/support/support.dart';
import 'package:bunker/screens/transaction/controller/transaction_controller.dart';
import 'package:bunker/screens/transaction/transactions.dart';
import 'package:bunker/screens/wallet/wallet_page.dart';
import 'package:bunker/screens_mobile/account/account_settings_mobile.dart';
import 'package:bunker/screens_mobile/admin/view_desktop.dart';
import 'package:bunker/screens_mobile/overview/overview_mobile.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/texts/MyText.dart';
import '../../screens/home/update_profile.dart';
import '../../utils/date_utils.dart';
import '../../utils/my_local_storage.dart';
import '../../utils/size_utils.dart';
import '../wallet/receive_mobile.dart';
import '../wallet/wallet_page_mobile.dart';


class HomeMobile extends StatefulWidget {
  HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  late AssetController assetController;
  late HomeController homeController;
  late UserController userController;
  late AccountSettingController accountSettingController;
  late TransactionController transactionController;
  late DateTime time_start;
  late DateTime time_end;
  String interval="5m";
  late Timer _marketDataTimer;
  late Timer _assetTimer;
  ValueNotifier<bool> assetLoadingNotifier=ValueNotifier(true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetController=Provider.of<AssetController>(context,listen: false);
    homeController=Provider.of<HomeController>(context,listen: false);
    userController=Provider.of<UserController>(context,listen: false);
    accountSettingController=Provider.of<AccountSettingController>(context,listen: false);
    transactionController=Provider.of<TransactionController>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
      String? token=await MyLocalStorage().getToken();
      userController.userCredential=UserCredential(token: token!);
      UserCredential? credential=UserCredential(token: token);
      log("User credential: $credential");
      if(credential!=null){
        UserCredential? credential=userController.userCredential;
        await accountSettingController.getProfile(credential: credential!);
        bool isFirstLogin=await MyLocalStorage().isFirstLogin();
        log("Is first login: $isFirstLogin");
        if(!isFirstLogin){
          showUpdateProfileDialog(context);
        }
        await MyLocalStorage().setIsFirstLogin(true);
        await assetController.getAssets(credential: credential);
        time_start=DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch-1000*60*60*24);
        time_end=DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,isUtc: true);
        assetController.getMarketQuotesHistorical(credential,MyDateUtils.dateToSingleFormat(time_start), MyDateUtils.dateToSingleFormatWithTime(time_end,true), interval);
        transactionController.getTransactions(credential: credential);
        getData(context: context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _marketDataTimer.cancel();
    _assetTimer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: primary_color,
      appBar: AppBar(
        backgroundColor: secondary_color,
        elevation: SizeUtils.getSize(context, 10.sp),
        centerTitle: false,
        leading: GestureDetector(
          onTap: (){
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<HomeController>(
        builder: (context, homeCtr, child) {
          return Container(
            height: height,
            width: width,
            color: primary_color,
            child: Consumer<HomeController>(
              builder: (context, homeCtr, child) {
                switch (homeCtr.currentPage) {
                  case 0:
                    return SizeUtils.isMobileView(context)?OverViewMobile():OverView();
                  case 1:
                    return SizeUtils.isMobileView(context)?AccountSettingsMobile():AccountSettings();
                  case 2:
                    return SizeUtils.isMobileView(context)?WalletPageMobile():WalletPage();
                  case 3:
                    return Transactions();
                  case 5:
                    return SizeUtils.isMobileView(context)?ViewDesktop():Admin();
                  case 4:
                    return Support();
                  default:
                    return OverView();
                }
              },
            ),
          );
        },
      ),
      drawer:  Consumer<HomeController>(
          builder: (context, homeCtr, child) {
          return Container(
            height: height,
            width: width*0.6,
            color:  Color(0xff161B29),
            padding: EdgeInsets.all(SizeUtils.getSize(context, 6.sp)),
            child: SingleChildScrollView(
              child: Consumer<AccountSettingController>(
                builder: (context, accountCtr, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      GestureDetector(
                        onTap: (){
                          context.go(AppRoutes.welcome);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: SizeUtils.getSize(context, 6.sp),
                            ),
                            SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                            MyText(
                              text: "Sign out",
                              color: primary_text_color,
                              weight: FontWeight.w400,
                              fontSize: SizeUtils.getSize(context, 3.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      MyText(
                        text: "GENERAL",
                        color: primary_text_color.withOpacity(0.4),
                        weight: FontWeight.w600,
                        fontSize: SizeUtils.getSize(context, 4.sp),
                        align: TextAlign.start,
                        maxLines: 3,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      GestureDetector(
                        onTap: (){
                          homeCtr.changePage(0);
                          if(SizeUtils.isMobileView(context)){
                            _scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
                          child: SideButton(
                            text: "Overview",
                            imageAsset: "assets/svgs/home.svg",
                            selectedColor: homeCtr.currentPage==0?action_button_color:secondary_color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homeCtr.changePage(1);
                          if(SizeUtils.isMobileView(context)){
                            _scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
                          child: SideButton(
                            text: "Account",
                            imageAsset: "assets/svgs/account.svg",
                            selectedColor: homeCtr.currentPage==1?action_button_color:secondary_color,

                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //         child: SideButton(
                      //             text: "Payments",
                      //             imageAsset: "assets/svgs/payment.svg"
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: (){
                          homeCtr.changePage(2);
                          if(SizeUtils.isMobileView(context)){
                            _scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
                          child: SideButton(
                            text: "Wallets",
                            imageAsset: "assets/svgs/wallet.svg",
                            selectedColor: homeCtr.currentPage==2?action_button_color:secondary_color,

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homeCtr.changePage(3);
                          if(SizeUtils.isMobileView(context)){
                            _scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
                          child: SideButton(
                            text: "Transactions",
                            imageAsset: "assets/svgs/transaction.svg",
                            selectedColor: homeCtr.currentPage==3?action_button_color:secondary_color,

                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          homeCtr.changePage(4);
                          if(SizeUtils.isMobileView(context)){
                            _scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
                          child: SideButton(
                            text: "Support",
                            imageAsset: "assets/svgs/support.svg",
                            selectedColor: homeCtr.currentPage==4?action_button_color:secondary_color,

                          ),
                        ),
                      ),
                      adminButton(accountCtr),

                    ],
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }

  void getData({required BuildContext context})async{
    getProfile(context: context);
    await getAssets(context: context);
    getMarketData(context: context);
    getAuthHistories(context: context);
  }
  Future<void> getMarketData({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        time_start=DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch-1000*60*60*24);
        time_end=DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,isUtc: true);
        assetController.getMarketQuotesHistorical(credential,MyDateUtils.dateToSingleFormat(time_start), MyDateUtils.dateToSingleFormatWithTime(time_end,true), interval);
        _marketDataTimer=Timer.periodic(const Duration(minutes: 2), (timer)async{
          try{
            log("Market data history: ${timer.tick}");
            time_start=DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch-1000*60*60*24);
            time_end=DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,isUtc: true);
            assetController.getMarketQuotesHistorical(credential,MyDateUtils.dateToSingleFormat(time_start), MyDateUtils.dateToSingleFormatWithTime(time_end,true), interval);

          }catch(e){
            log(e.toString());
            _marketDataTimer.cancel();
          }
        });
      }catch(e){

      }
    }
  }

  Future<void> getAssets({required BuildContext context})async{
    _assetTimer=Timer.periodic(const Duration(seconds: 30), (timer)async{
      try{
        log("Getting assets: ${timer.tick}");
        UserCredential? credential=userController.userCredential;
        if(credential!=null){
          try{
            await assetController.getAssets(credential: credential);
          }catch(e){

          }
        }
      }catch(e){
        log(e.toString());
        _assetTimer.cancel();
      }
    });
  }
  Future<void> getProfile({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        await accountSettingController.getProfile(credential: credential);
      }catch(e){

      }
    }
  }
  Future<void> getAuthHistories({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        await accountSettingController.getAuthHistory(credential: credential);
      }catch(e){

      }
    }
  }

  Widget adminButton(AccountSettingController accountCtr){
    ProfileModel? profileModel=accountCtr.profileModel;
    if(profileModel!=null){
      if(profileModel.roles!.contains("ROLE_ADMIN")){
        return GestureDetector(
          onTap: (){
            homeController.changePage(5);
            if(SizeUtils.isMobileView(context)){
              _scaffoldKey.currentState?.closeDrawer();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: SizeUtils.getSize(context, 2.sp)),
            child: SideButton(
                text: "Admin",
                imageAsset: "assets/svgs/admin.svg",
              selectedColor: homeController.currentPage==5?action_button_color:secondary_color,

            ),
          ),
        );
      }else{
        return const SizedBox();
      }
    }else{
      return const SizedBox();
    }
  }

  void showUpdateProfileDialog(BuildContext context){
    showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: primary_color,
              scrollable: true,
              content: Container(
                clipBehavior: Clip.hardEdge,
                height: height*0.5,
                padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 6.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                ),
                child: SizeUtils.isMobileView(context)?UpdateProfileDialog():SizedBox(
                    width: width*0.8,
                    child: UpdateProfileDialog()
                ),
              ),
            ),
          );
        }
    );
  }
}
