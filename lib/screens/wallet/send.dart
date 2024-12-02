import 'dart:developer';

import 'package:bunker/components/dialogs/my_dialog.dart';
import 'package:bunker/components/loading.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/snackbar/show_snack_bar.dart';
import '../../components/texts/MyText.dart';
import '../../user/controller/user_controller.dart';
import '../../utils/size_utils.dart';
import '../transaction/controller/withrawal_controller.dart';
class Send extends StatelessWidget {
  Send({super.key,required this.asset});
  AssetModel asset;
  TextEditingController amountController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  late UserController userController;
  late WithdrawalController withdrawalController;
  late AssetController assetController;
  ValueNotifier<bool> formValidation=ValueNotifier(false);


  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    withdrawalController=Provider.of<WithdrawalController>(context,listen: false);
    assetController=Provider.of<AssetController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Loading(size: SizeUtils.getSize(context, 10.sp),),
      overlayOpacity: 0.1,
      child: Container(
        padding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
        width: width,
        child: Form(
          key: _formKey,
          onChanged: (){
            if(_formKey.currentState!.validate()){
              formValidation.value=true;
            }else{
              formValidation.value=false;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  text: "Amount",
                  color: primary_text_color.withOpacity(0.8),
                  weight: FontWeight.w400,
                  fontSize: SizeUtils.getSize(context, 3.sp),
                  align: TextAlign.start
              ),
              SizedBox(height: SizeUtils.getSize(context, 2.sp)),
              TextFormField(
                controller: amountController,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  color: primary_text_color,
                  fontSize: SizeUtils.getSize(context, 4.sp),
                ),
                decoration: textFieldDecoration.copyWith(
                    hintText: "Amount",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     TextButton(
                    //       onPressed: (){
                    //         FlutterClipboard.paste().then((value) {
                    //           amountController.text=value.trim();
                    //         });
                    //       },
                    //       child: MyText(
                    //           text: "MAX",
                    //           color: primary_color_button,
                    //           weight: FontWeight.w400,
                    //           fontSize: ,
                    //           align: TextAlign.start
                    //       ),
                    //     ),
                    //   ],
                    // )
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (val) {
                  if(val!.isEmpty) {
                    return "Invalid amount";
                  } else if(double.tryParse(val) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              SizedBox(height: SizeUtils.getSize(context, 6.sp)),
              ValueListenableBuilder(
                  valueListenable: formValidation,
                  builder: (context,value,_) {
                    return MyButton(
                      text: "Withdraw",
                      borderColor: value?primary_color_button:action_button_color,
                      bgColor: value?primary_color_button:action_button_color,
                      txtColor: value?primary_text_color:primary_color_button,
                      verticalPadding: buttonVerticalPadding,
                      width: width,
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          try{
                            context.loaderOverlay.show();
                            String amount=amountController.text.trim();
                            await withdrawalController.createWithdrawalTicket(credential: userController.userCredential!, amount: double.parse(amount), walletId: asset.id!);
                            amountController.clear();
                            ShowSnackBar.show(context, "Withdrawal ticket submitted, please wait till the admin review the submission",Colors.greenAccent);
                            assetController.deductBalance(asset.id!, double.parse(amount));
                            context.loaderOverlay.hide();
                          }catch(e){
                            log(e.toString());
                            context.loaderOverlay.hide();
                            MyDialog.showDialog(context: context, message: "Unable to withdraw", icon: Icons.info_outline, iconColor: Colors.redAccent);
                          }
                        }
                      },
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
