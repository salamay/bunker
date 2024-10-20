import 'dart:async';
import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/screens/admin/components/ticket_item.dart';
import 'package:bunker/screens/admin/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/texts/MyText.dart';
import '../../user/controller/user_controller.dart';
import '../../user/model/user_crendential.dart';
import '../../utils/size_utils.dart';
import '../home/components/my_icon_button.dart';
import '../home/components/top_row.dart';

class Tickets extends StatefulWidget {
  Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  late UserController userController;
  late AdminController adminController;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController=Provider.of<UserController>(context,listen: false);
    adminController=Provider.of<AdminController>(context,listen: false);
    getTickets(context: context);
    _timer=Timer.periodic(const Duration(seconds: 30), (timer)async{
      try{
        getTickets(context: context);
      }catch(e){
        log(e.toString());
        _timer.cancel();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondary_color,
          elevation: SizeUtils.getSize(context, 10.sp),
          centerTitle: false,
          title: Row(
            children: [
              TopRow(),
              const Spacer(),
              GestureDetector(
                  onTap: (){
                    context.pop();
                  },
                  child: MyIconButton(text: "Back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
              ),
            ],
          )
      ),
      body: Container(
          width: width,
          height: height,
          color: primary_color,
          padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
          child: SingleChildScrollView(
            child: Consumer<AdminController>(
              builder: (context, adminCtr, child) {
                return Column(
                  children: [
                    SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: "Tickets",
                        color: primary_text_color,
                        weight: FontWeight.w600,
                        fontSize: SizeUtils.getSize(context, 8.sp),
                        align: TextAlign.start,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: adminCtr.withdrawalTickets.map((e)=>TicketItem(ticket: e)).toList(),
                    ),
                  ],
                );
              },
            ),
          )
      ),
    );
  }
  void getTickets({required context})async{
    try{
      UserCredential? credential=userController.userCredential;
      if(credential!=null){
        adminController.getTickets(credential: credential);

      }
    }catch(e){
      log(e.toString());
    }
  }
}
