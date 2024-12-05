import 'dart:developer';

import 'package:bunker/supported_assets/model/assets.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/snackbar/show_snack_bar.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
class ReceiveMobile extends StatelessWidget {
  ReceiveMobile({super.key,required this.asset});
  AssetModel asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      width: width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              padding: EdgeInsets.all(SizeUtils.getSize(context, 4.sp)),
              decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orangeAccent,
                    size: SizeUtils.getSize(context, 4.sp),
                  ),
                  SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                  SizedBox(
                    width: width*0.2,
                    child: MyText(
                        text: "Send only ${asset.symbol} to this address, other assets may be lost forever",
                        color: Colors.orangeAccent,
                        weight: FontWeight.w500,
                        fontSize: SizeUtils.getSize(context, 3.sp),
                        maxLines: 7,
                        align: TextAlign.center
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeUtils.getSize(context, 6.sp),),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: PrettyQr(
                  data: "0xhhdgfhjsdfhjdsfhjdsjk",
                  elementColor: primary_text_color,
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true,
                ),
              ),
            ),
            SizedBox(height: SizeUtils.getSize(context, 5.sp),),
            MyText(
                text: "Scan Address to receive payment",
                color: primary_text_color.withOpacity(0.8),
                weight: FontWeight.w400,
                fontSize: SizeUtils.getSize(context, 4.sp),
                maxLines: 4,
                align: TextAlign.center
            ),
            SizedBox(height: SizeUtils.getSize(context, 4.sp),),
            MyText(
                text: asset.address!,
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: SizeUtils.getSize(context, 3.sp),
                maxLines: 2,
                align: TextAlign.center
            ),
            SizedBox(height: SizeUtils.getSize(context, 2.sp),),
            GestureDetector(
                onTap: (){
                  FlutterClipboard.copy(asset.address!).then((value) => log(asset.address!));
                  ShowSnackBar.show(context, "Copied!",Colors.greenAccent);
                },
                child: Icon(
                  Icons.copy_all_sharp,
                  size: SizeUtils.getSize(context, 6.sp),
                  color: primary_icon_color,
                )
            ),
          ],
        ),
      ),
    );
  }
}
