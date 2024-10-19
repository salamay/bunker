import 'dart:developer';

import 'package:bunker/screens/home/components/listtile_shimmer.dart';
import 'package:bunker/screens/transaction/controller/transaction_controller.dart';
import 'package:bunker/screens/transaction/transaction_item.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/app_component.dart';
import '../../components/texts/MyText.dart';
import '../empty/empty_page.dart';

class TransactionModal extends StatelessWidget {
  const TransactionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp), horizontal: SizeUtils.getSize(context, 4.sp)),
      child: SingleChildScrollView(
        child: Consumer<TransactionController>(
            builder: (context, transactionCtr, child) {
              log(transactionCtr.transactionLoading.toString());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Transactions",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: SizeUtils.getSize(context, 6.sp),
                    align: TextAlign.start,
                    maxLines: 1,
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  Container(
                    decoration: BoxDecoration(
                        color: secondary_color,
                        borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, cornerRadius)))
                    ),
                    child: Skeletonizer(
                        ignoreContainers: false,
                        enabled: transactionCtr.transactionLoading,
                        enableSwitchAnimation: true,
                        effect: ShimmerEffect(
                            duration: const Duration(milliseconds: 1000),
                            baseColor: secondary_color.withOpacity(0.6),
                            highlightColor: action_button_color.withOpacity(0.8)
                        ),
                      child: !transactionCtr.transactionLoading? transactionCtr.transactions.isEmpty?Container(
                        width: width,
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: secondary_color.withOpacity(0.3),
                            borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                        ),
                        child: EmptyPage(
                            title: "Oops! Nothing is here",
                            subtitle: "We couldn't find any transaction"
                        ),
                      ):Column(
                        children: transactionCtr.transactions.map((e) => Container(
                          padding: EdgeInsets.only(bottom: SizeUtils.getSize(context, 2.sp)),
                          child: TransactionItem(transactionModel: e),
                        )).toList(),
                      ):const ListTileShimmer(),
                    ),
                  )

                ],
              );
            }
        ),
      ),
    );
  }
}
