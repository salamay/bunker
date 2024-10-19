import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/support/model/TicketMessage.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/utils/date_helper.dart';
import 'package:bunker/utils/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../utils/size_utils.dart';
class MessageItem extends StatelessWidget {
  MessageItem({super.key,required this.message});
  TicketMessage message;
  @override
  Widget build(BuildContext context) {

    return Consumer<AccountSettingController>(
      builder: (context,accountCtr,_) {
        ProfileModel? profile=accountCtr.profileModel;
        int userId=0;
        if(profile!=null){
          userId=profile.userId??0;
        }
        return message.senderUid==userId?Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp)),
            padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
            decoration: BoxDecoration(
              color: secondary_color,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                message.isMedia!=false?Hero(
                  tag: message.id!,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ImagePreview(tag: message.id!, imageUrl: message.imageUrl!)));
                    },
                    child: Container(
                      height: SizeUtils.getSize(context, 20.sp),
                      width: SizeUtils.getSize(context, 20.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cornerRadius),
                        image: DecorationImage(
                          image: NetworkImage(message.imageUrl!),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ):const SizedBox(),
                MyText(
                  text: message.message!,
                  color: primary_text_color,
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 8,
                ),
                MyText(
                  text: parseDate(message.createdAt!),
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 2.sp),
                  align: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ):Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: width*0.3,
            margin: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp)),
            padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
            decoration: BoxDecoration(
              color: secondary_color,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                message.isMedia!=false?Hero(
                  tag: message.id!,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ImagePreview(tag: message.id!, imageUrl: message.imageUrl!)));
                    },
                    child: Container(
                      height: SizeUtils.getSize(context, 20.sp),
                      width: SizeUtils.getSize(context, 20.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cornerRadius),
                          image: DecorationImage(
                              image: NetworkImage(message.imageUrl!),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                ):const SizedBox(),
                MyText(
                  text: message.message!,
                  color: primary_text_color,
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: parseDate(message.createdAt!),
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 2.sp),
                  align: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      }
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
