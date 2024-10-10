import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/admin/components/admin_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../components/texts/MyText.dart';
class Admin extends StatelessWidget {
  Admin({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: primary_color,
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  context.push(AppRoutes.adminWithdrawalTickets);
                },
                child: Container(
                  margin: EdgeInsets.all(2.sp),
                  child: AdminItem(
                      title: "Withdrawals",
                      imageAsset: "assets/svgs/withdrawal.svg"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(2.sp),
                child: AdminItem(
                    title: "Deposit",
                    imageAsset: "assets/svgs/deposit.svg"
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
