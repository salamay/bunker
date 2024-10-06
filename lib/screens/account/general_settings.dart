import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/button/MyButton.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
class GeneralSettings extends StatelessWidget {
  GeneralSettings({super.key});
  final _formKey= GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController(text: "ayotundesalam@gmail.com");
  final TextEditingController firstNameController=TextEditingController();
  final TextEditingController lastNameController=TextEditingController();
  final TextEditingController addressController=TextEditingController();
  ValueNotifier<String> dobNotifier=ValueNotifier("");
  ValueNotifier<String> countryNotifier=ValueNotifier("");
  ValueNotifier<String> stateNotifier=ValueNotifier("");
  ValueNotifier<String> cityNotifier=ValueNotifier("");
  ValueNotifier<String> postalCodeNotifier=ValueNotifier("");
  ValueNotifier<bool> formValidation=ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
      height: height,
      decoration: BoxDecoration(
        color: secondary_color,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                    controller: emailController,
                    style: GoogleFonts.poppins(
                        color: primary_text_color.withOpacity(0.3),
                        fontSize: 3.sp,
                        fontWeight: FontWeight.w300
                    ),
                    textAlign: TextAlign.start,
                    hintText: "Email address",
                    enable: false,
                    textInputType: TextInputType.emailAddress,
                    errorText: "Invalid email",
                    maxLines: 1,
                    obscureText: false,
                    onEditingComplete: () {

                    },
                    onFieldSubmitted: null,
                    validator: (val)=>!EmailValidator.validate(val!)?"Please provide your email":null,
                  ),
                  SizedBox(height: 2.sp,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyFormField(
                          controller: firstNameController,
                          textAlign: TextAlign.start,
                          hintText: "First name",
                          enable: true,
                          textInputType: TextInputType.emailAddress,
                          errorText: "Invalid first name",
                          maxLines: 1,
                          obscureText: false,
                          onEditingComplete: () {
                        
                          },
                          onFieldSubmitted: null,
                          validator: (val)=>val!.isEmpty?"Enter first name":null,
                        ),
                      ),
                      SizedBox(width: 4.sp,),
                      Expanded(
                        child: MyFormField(
                          controller: lastNameController,
                          textAlign: TextAlign.start,
                          hintText: "Last name",
                          enable: true,
                          textInputType: TextInputType.emailAddress,
                          errorText: "Invalid last name",
                          maxLines: 1,
                          obscureText: false,
                          onEditingComplete: () {
                        
                          },
                          onFieldSubmitted: null,
                          validator: (val)=>val!.isEmpty?"Enter last name":null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.sp,),
                  CSCPicker(
                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: true,
                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: true,
                    layout: Layout.horizontal,
                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: CountryFlag.ENABLE,
                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                        color: primary_color,
                        border: Border.all(
                            color: primary_border_color,
                            width: 0.2
                        )
                    ),
                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                        color: primary_color,
                        border: Border.all(
                            color: primary_border_color,
                            width: 0.2
                        )
                    ),
                    ///placeholders for dropdown search field
                    ///labels for dropdown
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",
                    defaultCountry: CscCountry.Cyprus,
                    ///selected item style [OPTIONAL PARAMETER]
                    selectedItemStyle: GoogleFonts.poppins(
                        color: primary_text_color.withOpacity(0.6),
                        fontWeight: FontWeight.normal
                    ),
                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: GoogleFonts.poppins(
                        color: primary_text_color,
                        fontSize: 4.sp,
                        fontWeight: FontWeight.normal
                    ),
                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: GoogleFonts.poppins(
                        color: primary_text_color,
                        fontSize: 4.sp,
                        fontWeight: FontWeight.w300
                    ),
                    ///Dialog box radius [OPTIONAL PARAMETER]
                    dropdownDialogRadius: cornerRadius,
                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: cornerRadius,
                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {
                      log(value);
                      countryNotifier.value = value;
                    },

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {
                      if(value!=null){
                         stateNotifier.value = value;
                      }
                    },
                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      if(value!=null){
                        cityNotifier.value = value;
                      }

                    },
                  ),
                  SizedBox(height: 4.sp,),
                  ValueListenableBuilder(
                      valueListenable: formValidation,
                      builder: (context,value,_) {
                        return MyButton(
                          text: "Save changes",
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
                  )
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}