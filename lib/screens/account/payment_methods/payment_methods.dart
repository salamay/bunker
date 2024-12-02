import 'dart:ui';

import 'package:bunker/screens/account/payment_methods/add_payment_method.dart';
import 'package:bunker/screens/account/payment_methods/model/payment_method_model.dart';
import 'package:bunker/screens/empty/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_component.dart';
import '../../../components/button/MyButton.dart';
import '../../../components/texts/MyText.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../../utils/size_utils.dart';
import '../../home/components/listtile_shimmer.dart';
import '../controller/account_setting_controller.dart';
import 'components/payment_item.dart';
class PaymentMethods extends StatefulWidget {
  PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {

  late UserController userController;
  late AccountSettingController accountSettingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController=Provider.of<UserController>(context,listen: false);
    accountSettingController=Provider.of<AccountSettingController>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getPaymentMethods(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 8.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        decoration: BoxDecoration(
          color: secondary_color,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: SingleChildScrollView(
            child: Consumer<AccountSettingController>(
                builder: (context,accountCtr,_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "Payment Methods",
                            color: primary_text_color,
                            weight: FontWeight.w400,
                            fontSize: SizeUtils.getSize(context, 4.sp),
                            align: TextAlign.start,
                            maxLines: 1,
                          ),
                          MyButton(
                            text: "+ Add",
                            borderColor: primary_color_button,
                            bgColor: primary_color_button,
                            txtColor: primary_text_color,
                            verticalPadding: buttonVerticalPadding,
                            bgRadius: SizeUtils.getSize(context, 2.sp),
                            width: width*0.1,
                            onPressed: ()async{
                              showAdaptiveDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context){
                                    return BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                      child: AlertDialog(
                                        backgroundColor: primary_color,
                                        content: Container(
                                          width: width*0.3,
                                          clipBehavior: Clip.hardEdge,
                                          padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 6.sp),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                                          ),
                                          child: AddPaymentMethod(),
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                          )
                        ],
                      ),
                      MyText(
                        text: "You can add or remove your payment methods here",
                        color: primary_text_color.withOpacity(0.8),
                        weight: FontWeight.w400,
                        fontSize: SizeUtils.getSize(context, 3.sp),
                        align: TextAlign.start,
                        maxLines: 3,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                      Skeletonizer(
                        ignoreContainers: false,
                        enabled: accountCtr.paymentMethodsLoading,
                        enableSwitchAnimation: true,
                        effect: ShimmerEffect(
                            duration: const Duration(milliseconds: 1000),
                            baseColor: secondary_color.withOpacity(0.6),
                            highlightColor: action_button_color.withOpacity(0.8)
                        ),
                        child: SizedBox(
                          child: !accountCtr.paymentMethodsLoading?accountCtr.paymentMethods.isNotEmpty?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: accountCtr.paymentMethods.map((e){
                              return PaymentItem(methodModel: e);
                            }).toList(),
                          ):Center(child: EmptyPage(title: "Oops! Nothing is here", subtitle: "Add a payment method to get started")): ListTileShimmer()
                        ),
                      ),
                    ],
                  );
                }
            )
        ),
    );
  }
  Future<void> getPaymentMethods({required BuildContext context})async{
    UserCredential? credential=userController.userCredential;
    if(credential!=null){
      try{
        await accountSettingController.getPaymentMethods(credential: credential);
      }catch(e){

      }
    }
  }
}
