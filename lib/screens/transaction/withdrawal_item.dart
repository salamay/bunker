import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/transaction/model/withdrawal_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/texts/MyText.dart';
class WithdrawalItem extends StatelessWidget {
  WithdrawalItem({super.key,required this.withdrawalTicket});
  WithdrawalTicket withdrawalTicket;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: Colors.transparent,
      child: ListTile(
        hoverColor: action_button_color,
        tileColor: secondary_color,
        contentPadding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 2.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        onTap: (){
      
        },
        title:  MyText(
          text: "\$${withdrawalTicket.amount!.toStringAsFixed(2)}",
          color: Colors.red,
          weight: FontWeight.w600,
          fontSize: 4.sp,
          align: TextAlign.start,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: withdrawalTicket.date.toString(),
          color: primary_text_color,
          weight: FontWeight.w400,
          fontSize: 2.sp,
          align: TextAlign.start,
          maxLines: 1,
        ),
        trailing: resolveStatus(withdrawalTicket: withdrawalTicket)
      ),
    );
  }

  Widget resolveStatus({required WithdrawalTicket withdrawalTicket}){
    switch(withdrawalTicket.status!){
      case "Pending":
        return Container(
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.orange.withOpacity(0.3),
          ),
          child: MyText(
            text: "Pending",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: 3.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Approved":
        return Container(
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.greenAccent.withOpacity(0.3),
          ),
          child: MyText(
            text: "Approved",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: 4.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Rejected":
        return Container(
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.redAccent.withOpacity(0.3),
          ),
          child: MyText(
            text: "Rejected",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: 3.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      default:
        return SizedBox();
    }
  }
}
