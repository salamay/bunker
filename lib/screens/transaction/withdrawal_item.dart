import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/transaction/model/withdrawal_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
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
        tileColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 0.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        onTap: (){
      
        },
        title:  MyText(
          text: "\$${withdrawalTicket.amount!.toStringAsFixed(2)}",
          color: Colors.red,
          weight: FontWeight.w600,
          fontSize: SizeUtils.getSize(context, 4.sp),
          align: TextAlign.start,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: withdrawalTicket.date.toString(),
          color: primary_text_color.withOpacity(0.5),
          weight: FontWeight.w400,
          fontSize: SizeUtils.getSize(context, 2.sp),
          align: TextAlign.start,
          maxLines: 1,
        ),
        trailing: resolveStatus(context: context,withdrawalTicket: withdrawalTicket)
      ),
    );
  }

  Widget resolveStatus({required BuildContext context,required WithdrawalTicket withdrawalTicket}){
    switch(withdrawalTicket.status!){
      case "Pending":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
            color: Colors.orange,
          ),
          child: MyText(
            text: "Pending",
            color: Colors.white,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Approved":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp),vertical: SizeUtils.getSize(context, 1.sp)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
            color: Colors.green,
          ),
          child: MyText(
            text: "Approved",
            color: Colors.white,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Rejected":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp),vertical: SizeUtils.getSize(context, 1.sp)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeUtils.getSize(context, cornerRadius)),
            color: Colors.redAccent,
          ),
          child: MyText(
            text: "Rejected",
            color: Colors.white,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
