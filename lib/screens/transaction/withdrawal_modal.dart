import 'package:bunker/screens/home/components/listtile_shimmer.dart';
import 'package:bunker/screens/transaction/withdrawal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../components/app_component.dart';
import '../../components/texts/MyText.dart';
import '../../utils/size_utils.dart';
import '../empty/empty_page.dart';
import 'controller/withrawal_controller.dart';
class WithdrawalModal extends StatelessWidget {
  const WithdrawalModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp), horizontal: SizeUtils.getSize(context, 4.sp)),

      child: SingleChildScrollView(
        child: Consumer<WithdrawalController>(
            builder: (context, withdrawalCtr, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Withdrawals",
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
                        enabled: withdrawalCtr.withdrawalLoading,
                        enableSwitchAnimation: true,
                        effect: ShimmerEffect(
                            duration: const Duration(milliseconds: 1000),
                            baseColor: secondary_color.withOpacity(0.6),
                            highlightColor: action_button_color.withOpacity(0.8)
                        ),
                      child: !withdrawalCtr.withdrawalLoading?withdrawalCtr.withdrawalTickets.isEmpty?Container(
                        width: width,
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: secondary_color,
                            borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                        ),
                        child: EmptyPage(
                            title: "Oops! Nothing is here",
                            subtitle: "We couldn't find any withdrawal"
                        ),
                      ):Column(
                        children: withdrawalCtr.withdrawalTickets.map((e) => Container(
                          padding: EdgeInsets.only(bottom: SizeUtils.getSize(context, 2.sp)),
                          child: WithdrawalItem(withdrawalTicket: e),
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
