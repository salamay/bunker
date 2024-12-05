import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/wallet/receive.dart';
import 'package:bunker/screens/wallet/send.dart';
import 'package:bunker/screens_mobile/wallet/receive_mobile.dart';
import 'package:bunker/screens_mobile/wallet/send_mobile.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/texts/MyText.dart';
import '../../screens/wallet/controller/wallet_controller.dart';
import '../../utils/size_utils.dart';

class SendAndReceiveModalMobile extends StatefulWidget {
  SendAndReceiveModalMobile({super.key,required this.asset});
  AssetModel asset;

  @override
  State<SendAndReceiveModalMobile> createState() => _SendAndReceiveModalMobileState();
}

class _SendAndReceiveModalMobileState extends State<SendAndReceiveModalMobile> with SingleTickerProviderStateMixin{
  late TabController pageController;
  ValueNotifier<WalletAction> settingTypeNotifier=ValueNotifier(WalletAction.send);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=TabController(length: 2, initialIndex: 0,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    bool isReceive=Provider.of<WalletController>(context).isReceive;
    SchedulerBinding.instance.addPostFrameCallback((time){
      if(isReceive){
        log("isReceive: $isReceive");
        pageController.animateTo(1);
      }else{
        log("isReceive: $isReceive");
        pageController.animateTo(0);
      }
    });
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      decoration: BoxDecoration(
        color: secondary_color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: pageController,
            dividerHeight: 0.1.sp,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            indicatorColor: primary_color_button,
            dividerColor: divider_color.withOpacity(0.1),
            labelPadding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context,1.sp)),
            tabs: [
              GestureDetector(
                onTap:(){
                  WalletController walletController=Provider.of<WalletController>(context,listen: false);
                  walletController.isReceive=false;
                  pageController.animateTo(0);
                },
                child: MyText(
                    text: "Withdrawal",
                    color: primary_text_color.withOpacity(0.8),
                    weight: FontWeight.w400,
                    fontSize: SizeUtils.getSize(context, 4.sp),
                    align: TextAlign.center
                ),
              ),
              GestureDetector(
                onTap:(){
                  WalletController walletController=Provider.of<WalletController>(context,listen: false);
                  walletController.isReceive=false;
                  pageController.animateTo(1);
                },
                child: MyText(
                    text: "Receive",
                    color: primary_text_color.withOpacity(0.8),
                    weight: FontWeight.w400,
                    fontSize: SizeUtils.getSize(context, 4.sp),
                    align: TextAlign.center
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.getSize(context, 8.sp),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeUtils.getSize(context, 8.sp),
                height: SizeUtils.getSize(context, 8.sp),
                child: CachedNetworkImage(
                  imageUrl: widget.asset.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Skeleton.replace(
                    child: Container(
                      width: SizeUtils.getSize(context, 8.sp),
                      height: SizeUtils.getSize(context, 8.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, cornerRadius))),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      width: SizeUtils.getSize(context, 8.sp),
                      height: SizeUtils.getSize(context, 8.sp),
                      child: Icon(Icons.error,size: SizeUtils.getSize(context, 10.sp),)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                child: MyText(
                  text: widget.asset.symbol!,
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: pageController,
              children: [
                SendMobile(asset: widget.asset),
                ReceiveMobile(asset: widget.asset)
              ],
            ),
          )
        ],
      ),
    );
  }
}
