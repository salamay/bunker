import 'package:bunker/components/snackbar/show_snack_bar.dart';
import 'package:bunker/screens/account/payment_methods/model/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../components/app_component.dart';
import '../../../../components/texts/MyText.dart';
import '../../../../user/controller/user_controller.dart';
import '../../../../user/model/user_crendential.dart';
import '../../../../utils/size_utils.dart';
import '../../controller/account_setting_controller.dart';
class PaymentItem extends StatelessWidget {
  PaymentItem({super.key,required this.methodModel});
  PaymentMethodModel methodModel;
  late UserController userController;
  late AccountSettingController accountSettingController;
  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    accountSettingController=Provider.of<AccountSettingController>(context,listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(color: secondary_border_color,width: 0.1.sp)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.food_bank_outlined,
            color: primary_color_button,
            size: SizeUtils.getSize(context, 10.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 4.sp)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Bank account",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: SizeUtils.getSize(context, 5.sp),
                  align: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                MyText(
                  text: methodModel.bankName!,
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: methodModel.accountName!,
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: methodModel.accountNumber!,
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: methodModel.routingNumber!,
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
                MyText(
                  text: methodModel.swiftCode!,
                  color: primary_text_color.withOpacity(0.6),
                  weight: FontWeight.w300,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                  align: TextAlign.start,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: ()async{
                UserCredential? credential=userController.userCredential;
                if(credential!=null){
                  try{
                    await accountSettingController.deletePaymentMethod(credential: credential,id: methodModel.id!);
                  }catch(e){
                    ShowSnackBar.show(context, "Unable to delete", Colors.red);
                  }
                }
              },
              icon: Icon(
                Icons.delete,
                color: primary_color_button,
                size: SizeUtils.getSize(context, 10.sp),
              ),
          )
        ],
      ),
    );
  }
}
