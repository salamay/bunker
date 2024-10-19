import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/divider.dart';
import 'package:bunker/components/loading.dart';
import 'package:bunker/screens/account/payment_methods/model/payment_method_model.dart';
import 'package:bunker/screens/account/payment_methods/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../../components/button/MyButton.dart';
import '../../../components/form/MyFormField.dart';
import '../../../components/snackbar/show_snack_bar.dart';
import '../../../components/texts/MyText.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../../utils/size_utils.dart';
import '../controller/account_setting_controller.dart';
class AddPaymentMethod extends StatelessWidget {
  AddPaymentMethod({super.key});
  final _formKey= GlobalKey<FormState>();
  final TextEditingController bankNameController=TextEditingController();
  final TextEditingController accountNameController=TextEditingController();
  final TextEditingController accountNumberController=TextEditingController();
  final TextEditingController routingNumberController=TextEditingController();
  final TextEditingController swiftNumberController=TextEditingController();
  final TextEditingController notesController=TextEditingController();
  late UserController userController;
  late AccountSettingController accountSettingController;


  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    accountSettingController=Provider.of<AccountSettingController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0.1,
      overlayWidget: Center(
        child: Loading(size: SizeUtils.getSize(context, 10.sp),),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: primary_color,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  text: "Add payment method",
                  color: primary_text_color,
                  weight: FontWeight.w600,
                  fontSize: SizeUtils.getSize(context, 6.sp),
                  align: TextAlign.start,
                  maxLines: 1,
                ),
                SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                MyDivider(),
                SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFormField(
                        controller: bankNameController,
                        textAlign: TextAlign.start,
                        hintText: "Bank name",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyFormField(
                        controller: accountNameController,
                        textAlign: TextAlign.start,
                        hintText: "Account name",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyFormField(
                        controller: accountNumberController,
                        textAlign: TextAlign.start,
                        hintText: "Account number",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyFormField(
                        controller: routingNumberController,
                        textAlign: TextAlign.start,
                        hintText: "Routing number",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyFormField(
                        controller: swiftNumberController,
                        textAlign: TextAlign.start,
                        hintText: "Swift code",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 1,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                      MyFormField(
                        controller: notesController,
                        textAlign: TextAlign.start,
                        hintText: "Notes",
                        enable: true,
                        textInputType: TextInputType.text,
                        errorText: "Must be provided",
                        maxLines: 3,
                        maxLength: 50,
                        obscureText: false,
                        onEditingComplete: () {

                        },
                        onFieldSubmitted: null,
                        validator: (val)=>val!.isEmpty?"Must be provided":null,
                      ),
                      SizedBox(height: SizeUtils.getSize(context, 6.sp),),
                      MyButton(
                        text: "Add",
                        borderColor: primary_color_button,
                        bgColor: primary_color_button,
                        txtColor: primary_text_color,
                        verticalPadding: buttonVerticalPadding,
                        bgRadius: SizeUtils.getSize(context, 4.sp),
                        width: width,
                        onPressed: ()async{
                          if(_formKey.currentState!.validate()){
                            try{
                              context.loaderOverlay.show();
                              String bankName=bankNameController.text.trim();
                              String accountName=accountNameController.text.trim();
                              String accountNumber=accountNumberController.text.trim();
                              String routingNumber=routingNumberController.text.trim();
                              String swiftNumber=swiftNumberController.text.trim();
                              String notes=notesController.text.trim();
                              log("Bank name: $bankName, Account name: $accountName, Account number: $accountNumber, Routing number: $routingNumber, Swift number: $swiftNumber, Notes: $notes");
                              PaymentMethodModel paymentMethodModel=PaymentMethodModel(bankName: bankName,accountName: accountName,accountNumber: accountNumber,routingNumber: routingNumber,swiftCode: swiftNumber,note: notes);
                              UserCredential? credential=userController.userCredential;
                              if(credential!=null){
                                await accountSettingController.addPaymentMethod(credential:credential, paymentMethod: paymentMethodModel);
                                context.pop();
                              }
                              context.loaderOverlay.hide();
                            }catch(e){
                              log(e.toString());
                              ShowSnackBar.show(context, "Unable to add payment method", Colors.red);
                              context.loaderOverlay.hide();
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
