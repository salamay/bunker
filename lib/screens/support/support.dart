import 'dart:ui';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/empty/empty_page.dart';
import 'package:bunker/screens/home/components/listtile_shimmer.dart';
import 'package:bunker/screens/support/components/ticketItem.dart';
import 'package:bunker/screens/support/controller/support_controller.dart';
import 'package:bunker/screens/support/create_ticket.dart';
import 'package:bunker/screens/support/message_view.dart';
import 'package:bunker/screens/support/model/support_ticket.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/texts/MyText.dart';
import '../../user/model/user_crendential.dart';
import '../home/components/my_icon_button.dart';
class Support extends StatefulWidget {
  Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  late SupportController supportController;
  late UserController userController;
  ValueNotifier<SupportTicket?> selectedTicketNotifier=ValueNotifier(null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    supportController=Provider.of<SupportController>(context,listen: false);
    userController=Provider.of<UserController>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timestamp)async{
      await userTickets(context: context);
      await getTicketMessage(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: ValueListenableBuilder(
        valueListenable: selectedTicketNotifier,
        builder: (context,selectedTicket,_) {
          return selectedTicket==null?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.getSize(context, 4.sp),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Create ticket",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: SizeUtils.getSize(context, 6.sp),
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  GestureDetector(
                    onTap: (){
                      showAdaptiveDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context){
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: AlertDialog(
                                contentPadding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 0.sp),vertical: SizeUtils.getSize(context, 0.sp)),
                                backgroundColor: primary_color,
                                content: Container(
                                  width: width*0.3,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                                  ),
                                  child: CreateTicket(),
                                ),
                              ),
                            );
                          }
                      );
                    },
                      child: MyIconButton(text: "Create", imageAsset: "assets/svgs/create.svg",color: primary_color_button,)
                  ),
                ],
              ),
              SizedBox(height: 4.sp,),
              Consumer<SupportController>(
                builder: (context,supportCtr,_) {
                  return Skeletonizer(
                    ignoreContainers: false,
                    enabled: supportCtr.supportTicketLoading,
                    enableSwitchAnimation: true,
                    effect: ShimmerEffect(
                        duration: const Duration(milliseconds: 1000),
                        baseColor: secondary_color.withOpacity(0.6),
                        highlightColor: action_button_color.withOpacity(0.8)
                    ),
                    child: !supportCtr.supportTicketLoading?supportCtr.supportTickets.isNotEmpty?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: supportCtr.supportTickets.map((e)=>TicketItem(
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
                            subtitle: "We couldn't find any support tickets. Create a new ticket to get started."
                        ),
                      ),
                    ):const ListTileShimmer(),
                  );
                }
              )
            ],
          ):MessageView(ticket: selectedTicket,backCallBack: (){
            selectedTicketNotifier.value=null;
          },);
        }
      ),
    );
  }

  Future<void> userTickets({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        await supportController.getUserTickets(credential: credential);
      }catch(e){

      }
    }
  }
  Future<void> getTicketMessage({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        List<SupportTicket> tickets=supportController.supportTickets;
        for(SupportTicket ticket in tickets){
          await supportController.loadTicketMessage(credential: credential, ticketId: ticket.id!);
        }
      }catch(e){

      }
    }
  }
}
