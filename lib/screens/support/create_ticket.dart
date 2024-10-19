import 'dart:developer';

import 'package:bunker/screens/support/controller/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/form/MyFormField.dart';
import '../../components/loading.dart';
import '../../components/snackbar/show_snack_bar.dart';
import '../../components/texts/MyText.dart';
import '../../user/controller/user_controller.dart';
import '../../user/model/user_crendential.dart';
import '../../utils/size_utils.dart';
import '../account/controller/account_setting_controller.dart';
import 'model/support_ticket.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});
  ValueNotifier<bool> formValidation=ValueNotifier(false);
  final _formKey= GlobalKey<FormState>();
  TextEditingController subjectController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  late UserController userController;
  late SupportController supportController;

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    supportController=Provider.of<SupportController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0.1,
      overlayWidget: Center(
        child: Loading(size: SizeUtils.getSize(context, 10.sp),),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.sp),
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: "Create a ticket",
                        color: primary_text_color,
                        weight: FontWeight.w600,
                        fontSize: SizeUtils.getSize(context, 6.sp),
                        align: TextAlign.start,
                        maxLines: 1,
                      ),
                      IconButton(
                          onPressed: (){
                            context.pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: primary_icon_color,
                            size: SizeUtils.getSize(context, 6.sp),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                  SizedBox(
                    width: width*0.4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyFormField(
                            controller: subjectController,
                            style: GoogleFonts.poppins(
                                color: primary_text_color.withOpacity(0.3),
                                fontSize: 3.sp,
                                fontWeight: FontWeight.w300
                            ),
                            textAlign: TextAlign.start,
                            hintText: "Subject",
                            enable: true,
                            textInputType: TextInputType.emailAddress,
                            errorText: "Subject",
                            maxLines: 1,
                            obscureText: false,
                            onEditingComplete: () {

                            },
                            onFieldSubmitted: null,
                            validator: (val)=>val!.isEmpty?"Please provide your email":null,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 1.sp),),
                          MyText(
                            text: "Ensure the ticket subject is relevant to your query",
                            color: primary_text_color.withOpacity(0.8),
                            weight: FontWeight.w300,
                            fontSize: SizeUtils.getSize(context, 2.sp),
                            align: TextAlign.start,
                            maxLines: 1,
                          ),
                          SizedBox(height: 2.sp,),
                          MyFormField(
                            controller: messageController,
                            textAlign: TextAlign.start,
                            hintText: "Message",
                            enable: true,
                            textInputType: TextInputType.emailAddress,
                            errorText: "Must not be empty",
                            maxLines: 4,
                            obscureText: false,
                            onEditingComplete: () {

                            },
                            onFieldSubmitted: null,
                            validator: (val)=>val!.isEmpty?"Must not be empty":null,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                          MyText(
                            text: "Please note that support tickets are usually answered within 24 hours, depending on the urgency of the ticket.",
                            color: primary_text_color.withOpacity(0.8),
                            weight: FontWeight.w300,
                            fontSize: SizeUtils.getSize(context, 2.sp),
                            align: TextAlign.start,
                            maxLines: 3,
                          ),
                          SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ValueListenableBuilder(
                                valueListenable: formValidation,
                                builder: (context,value,_) {
                                  return MyButton(
                                    text: "Create",
                                    borderColor: value?primary_color_button:secondary_color,
                                    bgColor: value?primary_color_button:action_button_color,
                                    txtColor: value?primary_text_color:primary_color_button,
                                    verticalPadding: buttonVerticalPadding,
                                    bgRadius: 2.sp,
                                    width: width,
                                    onPressed: ()async{
                                      if(_formKey.currentState!.validate()){
                                        try{
                                          context.loaderOverlay.show();
                                          String subject=subjectController.text.trim();
                                          String message=messageController.text.trim();
                                          SupportTicket supportTicket=SupportTicket(subject: subject, message: message);
                                          UserCredential? credential=userController.userCredential;
                                          if(credential!=null){
                                            await supportController.createTicket(credential:credential, supportTicket: supportTicket);
                                            context.pop();
                                          }
                                          context.loaderOverlay.hide();
                                        }catch(e){
                                          log(e.toString());
                                          context.loaderOverlay.hide();
                                          ShowSnackBar.show(context, "Unable to create ticket", Colors.red);
                                        }
                                      }
                                    },
                                  );
                                }
                            ),
                          )
                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
