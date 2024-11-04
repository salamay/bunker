import 'dart:async';
import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/empty/empty_page.dart';
import 'package:bunker/screens/transaction/controller/withrawal_controller.dart';
import 'package:bunker/screens/transaction/transaction_modal.dart';
import 'package:bunker/screens/transaction/withdrawal_item.dart';
import 'package:bunker/screens/transaction/withdrawal_modal.dart';
import 'package:bunker/user/controller/user_controller.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/texts/MyText.dart';
import '../home/components/my_icon_button.dart';
import 'controller/transaction_controller.dart';

class Transactions extends StatefulWidget {
  Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  late UserController userController;
  late WithdrawalController withdrawalController;
  late TransactionController transactionController;
  late Timer _timer;
  late TabController pageController;
  ValueNotifier<TxPage> txPageNotifier=ValueNotifier(TxPage.withdrawal);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=TabController(length: 2,vsync: this);
    userController=Provider.of<UserController>(context,listen: false);
    withdrawalController=Provider.of<WithdrawalController>(context,listen: false);
    transactionController=Provider.of<TransactionController>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getWithdrawals(context: context);
      getTransactions(context: context);
    });
    _timer=Timer.periodic(const Duration(seconds: 30), (timer)async{
      try{
        getWithdrawals(context: context);
        getTransactions(context: context);
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
    super.build(context); // Necessary for `AutomaticKeepAliveClientMixin`

    return Container(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: txPageNotifier,
              builder: (context,settingType,_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: pageController,
                      dividerHeight: 0.1.sp,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      indicatorColor: primary_color_button,
                      dividerColor: divider_color.withOpacity(0.1),
                      tabs: [
                        GestureDetector(
                          onTap:(){
                            txPageNotifier.value=TxPage.withdrawal;
                            pageController.animateTo(0);
                          },
                          child: MyText(
                              text: "Withdrawals",
                              color: primary_text_color.withOpacity(0.5),
                              weight: FontWeight.w400,
                              fontSize: 4.sp,
                              align: TextAlign.center
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            pageController.animateTo(1);
                            txPageNotifier.value=TxPage.deposit;
                          },
                          child: MyText(
                              text: "Deposit",
                              color: primary_text_color.withOpacity(0.5),
                              weight: FontWeight.w400,
                              fontSize: 4.sp,
                              align: TextAlign.center
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          Expanded(
            child: TabBarView(
              controller: pageController,
              children: [
                WithdrawalModal(),
                TransactionModal()

              ],
            ),
          )
        ],
      ) ,
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
  void getTransactions({required context})async{
    try{
      UserCredential? credential=userController.userCredential;
      if(credential!=null){
        transactionController.getTransactions(credential: credential);
      }
    }catch(e){
      log(e.toString());
    }
  }
  @override
  bool get wantKeepAlive => true;  // Keeps the widget alive
}
