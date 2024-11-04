import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/transaction/model/transaction_model.dart';
import 'package:bunker/screens/transaction/model/withdrawal_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/texts/MyText.dart';
class TransactionItem extends StatelessWidget {
  TransactionItem({super.key,required this.transactionModel});
  TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: Colors.transparent,
      child: ListTile(
          hoverColor: action_button_color,
          tileColor: Colors.transparent,
          isThreeLine: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 0.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          onTap: (){

          },
          title:  MyText(
            text: "\$${transactionModel.amount!.toStringAsFixed(2)}",
            color: Colors.red,
            weight: FontWeight.w600,
            fontSize: 4.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: transactionModel.walletSymbol??"",
                color: primary_text_color,
                weight: FontWeight.w400,
                fontSize: 3.sp,
                align: TextAlign.start,
                maxLines: 1,
              ),
              MyText(
                text: transactionModel.date.toString(),
                color: primary_text_color.withOpacity(0.5),
                weight: FontWeight.w400,
                fontSize: 2.sp,
                align: TextAlign.start,
                maxLines: 1,
              ),
            ],
          ),
          trailing: resolveStatus(tx: transactionModel)
      ),
    );
  }

  Widget resolveStatus({required TransactionModel tx}){
    switch(tx.status!){
      case "Pending":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.orange,
          ),
          child: MyText(
            text: "Pending",
            color: Colors.white,
            weight: FontWeight.w400,
            fontSize: 3.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Approved":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.green,
          ),
          child: MyText(
            text: "Approved",
            color: Colors.white,
            weight: FontWeight.w400,
            fontSize: 3.sp,
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Rejected":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.redAccent,
          ),
          child: MyText(
            text: "Rejected",
            color: Colors.white,
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
