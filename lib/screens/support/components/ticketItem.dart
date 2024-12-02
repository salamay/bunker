import 'package:bunker/screens/support/model/support_ticket.dart';
import 'package:bunker/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../utils/size_utils.dart';
class TicketItem extends StatelessWidget {
  TicketItem({super.key,required this.ticket,required this.callBack});
  SupportTicket ticket;
  Function callBack;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: ListTile(
          hoverColor: action_button_color.withOpacity(0.3),
          onTap: ()async{
            callBack.call();
          },
          leading: Container(
            padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
            decoration: BoxDecoration(
              color: ticket.status=="Open"?Colors.green:Colors.red,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: MyText(
              text: ticket.status!,
              color: primary_text_color,
              weight: FontWeight.w500,
              fontSize: SizeUtils.getSize(context, 4.sp),
              align: TextAlign.start,
              maxLines: 3,
            ),
          ),
          title: MyText(
            text: ticket.subject!,
            color: primary_text_color,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 4.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
          subtitle: SizedBox(
            width: width*0.2,
            child: MyText(
              text: ticket.message!,
              color: primary_text_color.withOpacity(0.8),
              weight: FontWeight.w300,
              fontSize: SizeUtils.getSize(context, 3.sp),
              align: TextAlign.start,
              maxLines: 3,
            ),
          ),
          trailing:  MyText(
            text: parseDate(ticket.createdAt!),
            color: primary_text_color.withOpacity(0.8),
            weight: FontWeight.w300,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 3,
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date){
    if(date.isToday){
      return "Today";
    }else if(date.isYesterday){
      return "Yesterday";
    }else{
      return DateFormat('EEEE, MMMM d, y').format(date);
    }
  }
}
