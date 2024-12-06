import 'dart:developer';

import 'package:bunker/components/app_component.dart';
import 'package:bunker/components/loading.dart';
import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import '../../components/button/MyButton.dart';
import '../../components/dialogs/my_dialog.dart';
import '../../components/form/MyFormField.dart';
import '../../components/texts/MyText.dart';
import '../../user/controller/user_controller.dart';
import '../../user/model/user_crendential.dart';
import '../../utils/size_utils.dart';

class GeneralSettings extends StatelessWidget {
  GeneralSettings({super.key});

  final _formKey= GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController firstNameController=TextEditingController();
  final TextEditingController lastNameController=TextEditingController();
  ValueNotifier<String?> dobNotifier=ValueNotifier(null);
  ValueNotifier<String?> countryNotifier=ValueNotifier(null);
  ValueNotifier<String?> stateNotifier=ValueNotifier(null);
  ValueNotifier<String?> cityNotifier=ValueNotifier(null);
  ValueNotifier<bool> formValidation=ValueNotifier(false);
  final TextEditingController addressController=TextEditingController();
  final TextEditingController postalController=TextEditingController();

  late UserController userController;
  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0.1,
      overlayWidget: Loading(size: SizeUtils.getSize(context, 10.sp),),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:SizeUtils.getSize(context, 6.sp), vertical: SizeUtils.getSize(context, 4.sp)),
        height: height,
        decoration: BoxDecoration(
          color: secondary_color,
          borderRadius: BorderRadius.circular(cornerRadius),
            boxShadow: [
              BoxShadow(
                color: primary_color,
                spreadRadius: 5,
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width*0.4,
              child: Form(
                key: _formKey,
                child: Consumer<AccountSettingController>(
                  builder: (context, accountCtr, child) {
                    ProfileModel? profile=accountCtr.profileModel;
                    if(profile!=null){
                      WidgetsBinding.instance.addPostFrameCallback((timestamp){
                        emailController.text=profile.email??"";
                        firstNameController.text=profile.firstName??"";
                        lastNameController.text=profile.lastName??"";
                        dobNotifier.value=profile.dob??"";
                        countryNotifier.value=profile.country??"";
                        stateNotifier.value=profile.state??"";
                        cityNotifier.value=profile.city??"";
                        addressController.text=profile.address??"";
                        postalController.text=profile.postalCode??"";
                      });
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(
                          text: "Basic details",
                          color: primary_text_color,
                          weight: FontWeight.w400,
                          fontSize: SizeUtils.getSize(context, 4.sp),
                          align: TextAlign.start,
                          maxLines: 1,
                        ),
                        SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                        MyFormField(
                          controller: emailController,
                          style: GoogleFonts.poppins(
                              color: primary_text_color.withOpacity(0.3),
                              fontSize: SizeUtils.getSize(context, 3.sp),
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
                        SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyFormField(
                                controller: firstNameController,
                                textAlign: TextAlign.start,
                                hintText: "First name",
                                enable: true,
                                textInputType: TextInputType.text,
                                errorText: "Invalid first name",
                                maxLines: 1,
                                obscureText: false,
                                onEditingComplete: () {

                                },
                                onFieldSubmitted: null,
                                validator: (val)=>val!.isEmpty?"Enter first name":null,
                              ),
                            ),
                            SizedBox(width: SizeUtils.getSize(context, 4.sp),),
                            Expanded(
                              child: MyFormField(
                                controller: lastNameController,
                                textAlign: TextAlign.start,
                                hintText: "Last name",
                                enable: true,
                                textInputType: TextInputType.text,
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
                        SizedBox(height: SizeUtils.getSize(context, 2.sp),),
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
                          countryDropdownLabel: countryNotifier.value??"Country",
                          stateDropdownLabel: stateNotifier.value??"State",
                          cityDropdownLabel: cityNotifier.value??"City",
                    ///selected item style [OPTIONAL PARAMETER]
                          selectedItemStyle: GoogleFonts.poppins(
                              color: primary_text_color.withOpacity(0.6),
                              fontWeight: FontWeight.normal
                          ),
                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          dropdownHeadingStyle: GoogleFonts.poppins(
                              color: primary_text_color,
                              fontSize: SizeUtils.getSize(context, 4.sp),
                              fontWeight: FontWeight.normal
                          ),
                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: GoogleFonts.poppins(
                              color: primary_text_color,
                              fontSize: SizeUtils.getSize(context, 4.sp),
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
                        SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                        MyFormField(
                          controller: addressController,
                          textAlign: TextAlign.start,
                          hintText: "Address",
                          enable: true,
                          textInputType: TextInputType.name,
                          errorText: "Invalid first name",
                          maxLines: 1,
                          obscureText: false,
                          onEditingComplete: () {

                          },
                          onFieldSubmitted: null,
                          validator: (val)=>val!.isEmpty?"Invalid address":null,
                        ),
                        SizedBox(height: SizeUtils.getSize(context, 2.sp),),
                        MyFormField(
                          controller: postalController,
                          textAlign: TextAlign.start,
                          hintText: "Postal code",
                          enable: true,
                          textInputType: TextInputType.number,
                          errorText: "Invalid postal code",
                          maxLines: 1,
                          obscureText: false,
                          onEditingComplete: () {

                          },
                          onFieldSubmitted: null,
                          validator: (val)=>val!.isEmpty?"Invalid postal":null,
                        ),
                        SizedBox(height: SizeUtils.getSize(context, 4.sp),),
                        ValueListenableBuilder(
                            valueListenable: formValidation,
                            builder: (context,value,_) {
                              return MyButton(
                                text: "Save changes",
                                borderColor: value?primary_color_button:secondary_color,
                                bgColor: value?primary_color_button:action_button_color,
                                txtColor: value?primary_text_color:primary_color_button,
                                verticalPadding: buttonVerticalPadding,
                                bgRadius: SizeUtils.getSize(context, 2.sp),
                                width: width,
                                onPressed: ()async{
                                  if(_formKey.currentState!.validate()){
                                    context.loaderOverlay.show();
                                    ProfileModel? profile=accountCtr.profileModel;
                                    if(profile!=null){
                                      String firstName=firstNameController.text.trim();
                                      String lastName=lastNameController.text.trim();
                                      String dob="";
                                      String country=countryNotifier.value??"";
                                      String state=stateNotifier.value??"";
                                      String city=cityNotifier.value??"";
                                      String address=addressController.text.trim();
                                      String postalCode=postalController.text.trim();
                                      profile.firstName=firstName;
                                      profile.lastName=lastName;
                                      profile.dob=dob;
                                      profile.country=country;
                                      profile.postalCode=postalCode;
                                      profile.state=state;
                                      profile.city=city;
                                      profile.address=address;
                                      profile.basicDetailsUpdated=true;
                                      UserCredential? credential=userController.userCredential;
                                      if(credential!=null){
                                        try{
                                          await accountCtr.updateProfile(credential: credential, profile: profile);
                                          context.loaderOverlay.hide();
                                          await MyDialog.showDialog(context: context, message: "Saved", icon: Icons.save_as_sharp, iconColor: Colors.green);

                                        }catch(e){
                                          log(e.toString());
                                          context.loaderOverlay.hide();
                                        }
                                      }else{
                                        context.loaderOverlay.hide();
                                      }
                                    }
                                  }
                                },
                              );
                            }
                        )
                      ],

                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
