import 'dart:developer';

import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_component.dart';
import '../../../components/texts/MyText.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../empty/empty_page.dart';
import '../../home/components/listtile_shimmer.dart';
import '../../home/components/my_icon_button.dart';
import '../../support/components/ticketItem.dart';
import '../../support/controller/support_controller.dart';
import '../../support/message_view.dart';
import '../../support/model/support_ticket.dart';
import 'admin_message_view.dart';
class AdminSupportTicket extends StatefulWidget {
  AdminSupportTicket({super.key});

  @override
  State<AdminSupportTicket> createState() => _AdminSupportTicketState();
}

class _AdminSupportTicketState extends State<AdminSupportTicket> {
  late SupportController supportController;
  late UserController userController;
  ValueNotifier<SupportTicket?> selectedTicketNotifier=ValueNotifier(null);

  void initState() {
    // TODO: implement initState
    super.initState();
    supportController=Provider.of<SupportController>(context,listen: false);
    userController=Provider.of<UserController>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      load();
    });
  }

  load()async{
    await allTicket(context: context);
    await getTicketMessage(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        child: ValueListenableBuilder(
            valueListenable: selectedTicketNotifier,
            builder: (context,selectedTicket,_) {
              return selectedTicket==null?SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "Users ticket",
                          color: primary_text_color,
                          weight: FontWeight.w600,
                          fontSize: SizeUtils.getSize(context, 6.sp),
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                        GestureDetector(
                            onTap: (){
                              context.pop();
                            },
                            child: MyIconButton(text: "Back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
                        ),
                      ],
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                    Consumer<SupportController>(
                        builder: (context,supportCtr,_) {
                          return Skeletonizer(
                            ignoreContainers: false,
                            enabled: supportCtr.adminSupportTicketLoading,
                            enableSwitchAnimation: true,
                            effect: ShimmerEffect(
                                duration: const Duration(milliseconds: 1000),
                                baseColor: secondary_color.withOpacity(0.6),
                                highlightColor: action_button_color.withOpacity(0.8)
                            ),
                            child: !supportCtr.adminSupportTicketLoading?supportCtr.adminSupportTickets.isNotEmpty?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: supportCtr.adminSupportTickets.map((e)=>TicketItem(
                                  ticket: e,
                                  callBack: (){
                                    selectedTicketNotifier.value=e;
                      
                                  },
                                )).toList()
                            ):Center(
                              child: Container(
                                padding: EdgeInsets.all(SizeUtils.getSize(context, 6.sp)),
                                decoration: BoxDecoration(
                                    color: secondary_color.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                                ),
                                child: EmptyPage(
                                    title: "Oops! Nothing is here",
                                    subtitle: "No ticket yet"
                                ),
                              ),
                            ):const ListTileShimmer(),
                          );
                        }
                    )
                  ],
                ),
              ):AdminMessageView(ticket: selectedTicket,backCallBack: (){
                selectedTicketNotifier.value=null;
              },);
            }
        ),
      ),
    );
  }


  Future<void> allTicket({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        await supportController.getAllTickets(credential: credential);
      }catch(e){

      }
    }
  }
  Future<void> getTicketMessage({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        List<SupportTicket> tickets=supportController.adminSupportTickets;
        log("Tickets: ${tickets.length}");
        for(SupportTicket ticket in tickets){
          await supportController.loadTicketMessageForAdmin(credential: credential, ticketId: ticket.id!);
        }
      }catch(e){

      }
    }
  }
}
