import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/loading.dart';
import 'package:bunker/screens/transaction/controller/withrawal_controller.dart';
import 'package:bunker/screens/transaction/model/withdrawal_ticket.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../../components/button/MyButton.dart';
import '../../../components/dialogs/my_dialog.dart';
import '../../../components/texts/MyText.dart';
import '../../../user/controller/user_controller.dart';
import '../../../utils/size_utils.dart';
import '../../home/components/my_icon_button.dart';
import '../controller/admin_controller.dart';
class TicketItem extends StatelessWidget {
  TicketItem({super.key,required this.ticket});
  WithdrawalTicket ticket;
  ValueNotifier<Color> _buttonColor=ValueNotifier<Color>(secondary_color.withOpacity(0.3));
  late UserController userController;
  late AdminController adminController;

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    adminController=Provider.of<AdminController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0.1,
      overlayWidget: Center(
          child: Loading(size: SizeUtils.getSize(context, 10.sp),)
      ),
      child: Material(
        borderRadius: BorderRadius.circular(cornerRadius),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: MouseRegion(
          onEnter: (event){
            _buttonColor.value=action_button_color.withOpacity(0.3);
          },
          onExit: (event){
            _buttonColor.value=secondary_color.withOpacity(0.3);
          },
          child: ValueListenableBuilder(
              valueListenable: _buttonColor,
              builder: (context,color,_) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: 4.sp),
                margin: EdgeInsets.only(bottom: SizeUtils.getSize(context, 2.sp)),
                width: width,
                color: color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: ticket.walletName.toString(),
                      color: Colors.green,
                      weight: FontWeight.w600,
                      fontSize: SizeUtils.getSize(context, 4.sp),
                      align: TextAlign.start,
                      maxLines: 1,
                    ),
                    MyText(
                      text: "\$${ticket.amount.toString()}",
                      color: primary_text_color.withOpacity(0.8),
                      weight: FontWeight.w500,
                      fontSize: SizeUtils.getSize(context, 3.sp),
                      align: TextAlign.start,
                      maxLines: 1,
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                    MyText(
                      text: ticket.email.toString(),
                      color: primary_text_color,
                      weight: FontWeight.w400,
                      fontSize: SizeUtils.getSize(context, 3.sp),
                      align: TextAlign.start,
                      maxLines: 1,
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        resolveStatus(context:context,withdrawalTicket: ticket),
                        const Spacer(),
                        ticket.status!=approved?MyButton(
                          text: "Approve",
                          borderColor: primary_color_button,
                          bgColor: Colors.green,
                          txtColor: primary_text_color,
                          verticalPadding: SizeUtils.getSize(context, 3.sp),
                          onPressed: ()async{
                            try{
                              UserCredential? credential=userController.userCredential;
                              if(credential!=null){
                                context.loaderOverlay.show();
                                await adminController.approveWithdrawal(credential: credential, withdrawalId: ticket.id!);
                                context.loaderOverlay.hide();
                              }
                            }catch(e){
                              log(e.toString());
                              MyDialog.showDialog(context: context, message: "Unable to approve", icon: Icons.info_outline, iconColor: Colors.redAccent);
                            }
                          },
                        ): const SizedBox(),
                        SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                        ticket.status!=rejected?MyButton(
                          text: "Reject",
                          borderColor: primary_color_button,
                          bgColor: Colors.redAccent,
                          txtColor: primary_text_color,
                          verticalPadding: SizeUtils.getSize(context, 3.sp),
                          onPressed: ()async{
                            try{
                              UserCredential? credential=userController.userCredential;
                              if(credential!=null){
                                context.loaderOverlay.show();
                                await adminController.rejectWithdrawal(credential: credential, withdrawalId: ticket.id!);
                                context.loaderOverlay.hide();
                              }
                            }catch(e){
                              log(e.toString());
                              MyDialog.showDialog(context: context, message: "Unable to reject ticket", icon: Icons.info_outline, iconColor: Colors.redAccent);
                            }
                          },
                        ):const SizedBox()
                      ],
                    )

                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget resolveStatus({required BuildContext context,required WithdrawalTicket withdrawalTicket}){
    switch(withdrawalTicket.status!){
      case "Pending":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.orangeAccent.withOpacity(0.1),
          ),
          child: MyText(
            text: "Pending",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Approved":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.greenAccent.withOpacity(0.3),
          ),
          child: MyText(
            text: "Approved",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      case "Rejected":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.sp,vertical: 1.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            color: Colors.redAccent.withOpacity(0.3),
          ),
          child: MyText(
            text: "Rejected",
            color: Colors.white60,
            weight: FontWeight.w400,
            fontSize: SizeUtils.getSize(context, 3.sp),
            align: TextAlign.start,
            maxLines: 1,
          ),
        );
      default:
        return SizedBox();
    }
  }
}
