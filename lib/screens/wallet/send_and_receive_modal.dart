import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/wallet/receive.dart';
import 'package:bunker/screens/wallet/send.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/texts/MyText.dart';
import 'controller/wallet_controller.dart';
class SendAndReceiveModal extends StatefulWidget {
  SendAndReceiveModal({super.key,required this.asset});
  AssetModel asset;

  @override
  State<SendAndReceiveModal> createState() => _SendAndReceiveModalState();
}

class _SendAndReceiveModalState extends State<SendAndReceiveModal> with SingleTickerProviderStateMixin{
  late TabController pageController;
  ValueNotifier<WalletAction> settingTypeNotifier=ValueNotifier(WalletAction.send);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: secondary_color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            controller: pageController,
            dividerHeight: 0.1.sp,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            indicatorColor: primary_color_button,
            dividerColor: divider_color.withOpacity(0.1),
            tabs: [
              GestureDetector(
                onTap:(){
                  pageController.animateTo(0);
                },
                child: MyText(
                    text: "Withdrawal",
                    color: primary_text_color.withOpacity(0.5),
                    weight: FontWeight.w400,
                    fontSize: 4.sp,
                    align: TextAlign.center
                ),
              ),
              GestureDetector(
                onTap:(){
                  pageController.animateTo(1);
                },
                child: MyText(
                    text: "Receive",
                    color: primary_text_color.withOpacity(0.5),
                    weight: FontWeight.w400,
                    fontSize: 4.sp,
                    align: TextAlign.center
                ),
              ),
            ],
          ),
          SizedBox(height: 8.sp,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 8.sp,
                height: 8.sp,
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
                      width: 8.sp,
                      height: 8.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                      width: 8.sp,
                      height: 8.sp,
                      child: Icon(Icons.error,size: 10.sp,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                child: MyText(
                  text: widget.asset.symbol!,
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: 4.sp,
                  align: TextAlign.start,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.sp,),
          Expanded(
            child: TabBarView(
              controller: pageController,
              children: [
                Send(asset: widget.asset),
                Receive(asset: widget.asset)
              ],
            ),
          )
        ],
      ),
    );
  }
}
