import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
import '../home/components/my_icon_button.dart';
import '../home/controller/home_controller.dart';
class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});
  ValueNotifier<bool> formValidation=ValueNotifier(false);
  final _formKey= GlobalKey<FormState>();
  TextEditingController subjectController=TextEditingController();
  TextEditingController messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.sp),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Create ticket",
                    color: primary_text_color,
                    weight: FontWeight.w600,
                    fontSize: 10.sp,
                    align: TextAlign.start,
                    maxLines: 3,
                  ),
                  GestureDetector(
                    onTap: (){
                      context.pop();
                    },
                      child: MyIconButton(text: "Go back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
                  ),
                ],
              ),
              SizedBox(height: 4.sp,),
              SizedBox(
                width: width*0.4,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyText(
                        text: "Basic details",
                        color: primary_text_color,
                        weight: FontWeight.w600,
                        fontSize: 4.sp,
                        align: TextAlign.start,
                        maxLines: 1,
                      ),
                      SizedBox(height: 8.sp,),
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
                      SizedBox(height: 4.sp,),
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
        
                                    // SendPayload payload=widget.sendPayload.copyWith(recipient_address: address);
                                    // context.push(AppRoutes.reviewTransaction,extra: payload);
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
    );
  }
}
