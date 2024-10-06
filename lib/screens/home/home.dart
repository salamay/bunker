import 'dart:async';
import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/account/account_settings.dart';
import 'package:bunker/screens/home/components/profile_widget.dart';
import 'package:bunker/screens/home/components/side_button.dart';
import 'package:bunker/screens/home/components/top_row.dart';
import 'package:bunker/screens/home/controller/home_controller.dart';
import 'package:bunker/screens/overview/overview.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../components/texts/MyText.dart';
import '../../utils/date_utils.dart';
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late AssetController assetController;
  late HomeController homeController;
  late DateTime time_start;
  late DateTime time_end;
  String interval="5m";
  late Timer _marketDataTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetController=Provider.of<AssetController>(context,listen: false);
    homeController=Provider.of<HomeController>(context,listen: false);
    time_start=DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch-1000*60*60*24);
    time_end=DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,isUtc: true);
    assetController.getMarketQuotesHistorical(MyDateUtils.dateToSingleFormat(time_start), MyDateUtils.dateToSingleFormatWithTime(time_end,true), interval);
    _marketDataTimer=Timer.periodic(const Duration(minutes: 2), (timer)async{
      try{
        log("Market data history: ${timer.tick}");
        time_start=DateTime.fromMillisecondsSinceEpoch(DateTime.now().toUtc().millisecondsSinceEpoch-1000*60*60*24);
        time_end=DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch,isUtc: true);
        assetController.getMarketQuotesHistorical(MyDateUtils.dateToSingleFormat(time_start), MyDateUtils.dateToSingleFormatWithTime(time_end,true), interval);

      }catch(e){
        log(e.toString());
        _marketDataTimer.cancel();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary_color,
      body: Container(
        height: height,
        width: width,
        color: primary_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: width*0.25,
              color: secondary_color,
              padding: EdgeInsets.all(6.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopRow(),
                  SizedBox(height: 4.sp,),
                  ProfileWidget(email: "ayotundesalam16@gmail.com"),
                  SizedBox(height: 4.sp,),
                  MyText(
                    text: "GENERAL",
                    color: primary_text_color.withOpacity(0.4),
                    weight: FontWeight.w600,
                    fontSize: 4.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  SizedBox(height: 2.sp,),
                  GestureDetector(
                    onTap: (){
                      homeController.changePage(0);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SideButton(
                                text: "Overview",
                                imageAsset: "assets/svgs/home.svg"
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      homeController.changePage(1);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SideButton(
                                text: "Account",
                                imageAsset: "assets/svgs/account.svg"
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SideButton(
                              text: "Payments",
                              imageAsset: "assets/svgs/payment.svg"
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SideButton(
                              text: "Wallets",
                              imageAsset: "assets/svgs/wallet.svg"
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SideButton(
                              text: "Transactoins",
                              imageAsset: "assets/svgs/transaction.svg"
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.sp,vertical: 2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SideButton(
                              text: "Support",
                              imageAsset: "assets/svgs/support.svg"
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                width: width,
                color: primary_color,
                child: Consumer<HomeController>(
                  builder: (context, homeCtr, child) {
                    switch (homeCtr.currentPage) {
                      case 0:
                        return OverView();
                      case 1:
                        return AccountSettings();
                      default:
                        return OverView();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
