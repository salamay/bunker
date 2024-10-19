import 'dart:developer';

import 'package:bunker/screens/admin/controller/admin_controller.dart';
import 'package:bunker/screens/admin/deposit/component/deposit_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_component.dart';
import '../../../components/button/MyButton.dart';
import '../../../components/dialogs/my_dialog.dart';
import '../../../components/loading.dart';
import '../../../components/snackbar/show_snack_bar.dart';
import '../../../components/texts/MyText.dart';
import '../../../supported_assets/controller/asset_controller.dart';
import '../../../supported_assets/model/assets.dart';
import '../../../user/controller/user_controller.dart';
import '../../../user/model/user_crendential.dart';
import '../../../utils/size_utils.dart';
import '../../home/components/my_icon_button.dart';
import '../../home/components/top_row.dart';
class DepositPage extends StatefulWidget {
  DepositPage({super.key,required this.assets});
  List<AssetModel> assets=[];

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  late ValueNotifier<AssetModel> selectedAsset;
  TextEditingController amountController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  ValueNotifier<bool> formValidation=ValueNotifier(false);
  late UserController userController;
  late AdminController adminController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController=Provider.of<UserController>(context,listen: false);
    adminController=Provider.of<AdminController>(context,listen: false);
    selectedAsset=ValueNotifier(widget.assets.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primary_color,
        appBar: AppBar(
            backgroundColor: secondary_color,
            elevation: SizeUtils.getSize(context, 10.sp),
            centerTitle: false,
            title: Row(
              children: [
                TopRow(),
                const Spacer(),
                GestureDetector(
                    onTap: (){
                      context.pop();
                    },
                    child: MyIconButton(text: "Back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
                ),
              ],
            )
        ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.getSize(context, 1.sp),),
              MyText(
                text: "Deposit",
                color: primary_text_color,
                weight: FontWeight.w600,
                fontSize: SizeUtils.getSize(context, 8.sp),
                align: TextAlign.start,
                maxLines: 3,
              ),
              SizedBox(height: SizeUtils.getSize(context, 4.sp),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height,
                    width: width*0.5,
                    padding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
                    decoration: BoxDecoration(
                      color: action_button_color.withOpacity(0.2),
                      boxShadow: [
                        BoxShadow(
                          color: primary_color,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.assets.map((e){
                          return DepositItem(asset: e,callBack: (){
                            selectedAsset.value=e;
                          },);
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.getSize(context, 4.sp),),
                  LoaderOverlay(
                    useDefaultLoading: true,
                    overlayWidget: Loading(size: SizeUtils.getSize(context, 10.sp),),
                    overlayOpacity: 0.1,
                    child: Container(
                      height: height,
                      width: width*0.3,
                      padding: EdgeInsets.all(SizeUtils.getSize(context, 8.sp)),
                      decoration: BoxDecoration(
                        color: action_button_color.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: primary_color,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child:Form(
                        key: _formKey,
                        onChanged: (){
                          if(_formKey.currentState!.validate()){
                            formValidation.value=true;
                          }else{
                            formValidation.value=false;
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedAsset,
                          builder: (context,asset,_) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeUtils.getSize(context, 8.sp),
                                      height: SizeUtils.getSize(context, 8.sp),
                                      child: CachedNetworkImage(
                                        imageUrl: asset.image!,
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Skeleton.replace(
                                          child: Container(
                                            width: SizeUtils.getSize(context, 8.sp),
                                            height: SizeUtils.getSize(context, 8.sp),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(SizeUtils.getSize(context, cornerRadius))),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => SizedBox(
                                            width: SizeUtils.getSize(context, 8.sp),
                                            height: SizeUtils.getSize(context, 8.sp),
                                            child: Icon(Icons.error,size: SizeUtils.getSize(context, 10.sp),)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: SizeUtils.getSize(context, 2.sp)),
                                      child: MyText(
                                        text: asset.symbol!,
                                        color: primary_text_color.withOpacity(0.8),
                                        weight: FontWeight.w400,
                                        fontSize: SizeUtils.getSize(context, 4.sp),
                                        align: TextAlign.start,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                MyText(
                                    text: "Amount",
                                    color: primary_text_color.withOpacity(0.8),
                                    weight: FontWeight.w400,
                                    fontSize: SizeUtils.getSize(context, 3.sp),
                                    align: TextAlign.start
                                ),
                                SizedBox(height: SizeUtils.getSize(context, 1.sp)),
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
                                SizedBox(height: SizeUtils.getSize(context, 8.sp),),
                                ValueListenableBuilder(
                                    valueListenable: formValidation,
                                    builder: (context,value,_) {
                                      return MyButton(
                                        text: "Top up",
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
                                              UserCredential? credential=userController.userCredential;
                                              if(credential!=null){
                                                await adminController.deposit(credential: credential, walletId: asset.id!, amount: amount);
                                                int i=widget.assets.indexOf(asset);
                                                log(i.toString());
                                                asset.balance=asset.balance!+double.parse(amount);
                                                widget.assets[i]=asset;
                                                setState(() {

                                                });
                                                ShowSnackBar.show(context, "You have successfully credited this user",Colors.greenAccent);
                                              }
                                              context.loaderOverlay.hide();
                                            }catch(e){
                                              log(e.toString());
                                              context.loaderOverlay.hide();
                                              MyDialog.showDialog(context: context, message: "Unable to top up", icon: Icons.info_outline, iconColor: Colors.redAccent);
                                            }
                                          }
                                        },
                                      );
                                    }
                                )
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
