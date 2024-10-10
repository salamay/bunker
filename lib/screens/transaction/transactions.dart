import 'dart:async';
import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/empty/empty_page.dart';
import 'package:bunker/screens/transaction/controller/withrawal_controller.dart';
import 'package:bunker/screens/transaction/withdrawal_item.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/texts/MyText.dart';
import '../home/components/my_icon_button.dart';
class Transactions extends StatefulWidget {
  Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late UserController userController;
  late WithdrawalController withdrawalController;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController=Provider.of<UserController>(context,listen: false);
    withdrawalController=Provider.of<WithdrawalController>(context,listen: false);
    getWithdrawals(context: context);
    _timer=Timer.periodic(const Duration(seconds: 30), (timer)async{
      try{
        getWithdrawals(context: context);
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
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8.sp),
      child:  SingleChildScrollView(
        child: Consumer<WithdrawalController>(
            builder: (context, withdrawalCtr, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.sp,),
                MyText(
                  text: "Withdrawals",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: 8.sp,
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                SizedBox(height: 4.sp,),
                withdrawalCtr.withdrawalTickets.isEmpty?Container(
                  width: width,
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                      color: secondary_color.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                  ),
                  child: EmptyPage(
                      title: "Oops! Nothing is here",
                      subtitle: "We couldn't find any withdrawal"
                  ),
                ):Column(
                  children: withdrawalCtr.withdrawalTickets.map((e) => Container(
                    padding: EdgeInsets.only(bottom: 2.sp),
                    child: WithdrawalItem(withdrawalTicket: e),
                  )).toList(),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
  void getWithdrawals({required context})async{
    try{
      UserCredential? credential=userController.userCredential;
      if(credential!=null){
        withdrawalController.getWithdrawals(credential: credential);

      }
    }catch(e){
      log(e.toString());
    }
  }
}
