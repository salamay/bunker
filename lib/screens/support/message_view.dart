import 'dart:developer';

import 'package:bunker/components/loading.dart';
import 'package:bunker/screens/support/controller/support_controller.dart';
import 'package:bunker/screens/support/model/TicketMessage.dart';
import 'package:bunker/screens/support/model/support_ticket.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../components/app_component.dart';
import '../../components/button/MyButton.dart';
import '../../components/form/MyFormField.dart';
import '../../components/snackbar/show_snack_bar.dart';
import '../../components/texts/MyText.dart';
import '../../user/controller/user_controller.dart';
import '../../user/model/user_crendential.dart';
import '../../utils/size_utils.dart';
import '../empty/empty_page.dart';
import '../home/components/my_icon_button.dart';
import 'components/message_item.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key,required this.ticket,required this.backCallBack});

  SupportTicket ticket;
  Function backCallBack;
  TextEditingController messageController=TextEditingController();
  final _formKey= GlobalKey<FormState>();
  late UserController userController;
  late SupportController supportController;
  ValueNotifier<bool> addingMessageNotifier=ValueNotifier(false);
  final ScrollController _scrollController = ScrollController();
  final ImagePicker picker = ImagePicker();
  ValueNotifier<XFile?> imageNotifier=ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    userController=Provider.of<UserController>(context,listen: false);
    supportController=Provider.of<SupportController>(context,listen: false);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 6.sp,horizontal: 4.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: (){
                            backCallBack.call();
                          },
                          child: MyIconButton(text: "Back", imageAsset: "assets/svgs/back.svg",color: primary_color_button,)
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 2.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
                      decoration: BoxDecoration(
                        color: ticket.status=="Open"?Colors.green:Colors.red,
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      child: MyText(
                        text: ticket.status!,
                        color: primary_text_color,
                        weight: FontWeight.w500,
                        fontSize: SizeUtils.getSize(context, 4.sp),
                        align: TextAlign.start,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: SizedBox(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<SupportController>(
                      builder: (context, supportCtr, child) {
                        List<TicketMessage> messages=supportCtr.ticketMessages[ticket.id]??[];
                        WidgetsBinding.instance.addPostFrameCallback((time){
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          }
                        });
                        return messages.isNotEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: messages.map((message) => MessageItem(message: message)).toList(),
                        ):Center(
                          child: Container(
                            padding: EdgeInsets.all(SizeUtils.getSize(context, 4.sp)),
                            decoration: BoxDecoration(
                                color: secondary_color.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(cornerRadius))
                            ),
                            child: EmptyPage(
                                title: "Oops! Nothing is here",
                                subtitle: "You have not received any message yet."
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyFormField(
                    controller: messageController,
                    textAlign: TextAlign.start,
                    hintText: "Message",
                    enable: true,
                    textInputType: TextInputType.text,
                    errorText: "Must be provided",
                    maxLines: 3,
                    maxLength: 400,
                    obscureText: false,
                    onEditingComplete: () {

                    },
                    onFieldSubmitted: null,
                    validator: (val)=>val!.isEmpty?"Must be provided":null,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          ValueListenableBuilder(
            valueListenable: addingMessageNotifier,
            builder: (context,isAdding,_) {
              return !isAdding?Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: imageNotifier,
                        builder: (context,imagePath,_) {
                        return GestureDetector(
                          onTap: (){
                            imageNotifier.value=null;
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: imagePath!=null?imagePath.path:"",
                              color: primary_text_color.withOpacity(0.6),
                              weight: FontWeight.w300,
                              fontSize: SizeUtils.getSize(context, 2.sp),
                              align: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                        );
                      }
                    ),
                    MyButton(
                      text: "+ Include image",
                      borderColor: primary_color_button,
                      bgColor: primary_color_button,
                      txtColor: primary_text_color,
                      verticalPadding: buttonVerticalPadding,
                      bgRadius: SizeUtils.getSize(context, cornerRadius),
                      onPressed: ()async{
                        if(kIsWeb){
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          if(image!=null){
                            log("Image: ${image.path}");
                            imageNotifier.value=image;
                          }
                        }
                      },
                    ),
                    SizedBox(width: SizeUtils.getSize(context, 2.sp),),
                    MyButton(
                      text: "Send message",
                      borderColor: primary_color_button,
                      bgColor: primary_color_button,
                      txtColor: primary_text_color,
                      verticalPadding: buttonVerticalPadding,
                      bgRadius: SizeUtils.getSize(context, cornerRadius),
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          try{
                            UserCredential? credential=userController.userCredential;
                            if(credential!=null){
                              addingMessageNotifier.value=true;
                              String message=messageController.text.trim();
                              String ticketId=ticket.id!;
                              String imageUrl="";
                              bool isMedia=false;
                              if(imageNotifier.value!=null){
                                var bytes=await imageNotifier.value!.readAsBytes();
                                imageUrl=await supportController.uploadImage(credential: credential, bytes: bytes);
                                isMedia=true;
                              }
                              await supportController.sendMessage(credential: credential, ticketId: ticketId, message: message, imageUrl: imageUrl, isMedia: isMedia);
                              messageController.clear();
                              addingMessageNotifier.value=false;
                              // Scroll to the bottom when new messages are added
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_scrollController.hasClients) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                }
                              });
                            }
                          }catch(e){
                            log(e.toString());
                            ShowSnackBar.show(context, "Unable to send message", Colors.red);
                            addingMessageNotifier.value=false;
                          }
                        }
                      },
                    ),
                  ],
                ),
              ):Align(
                alignment: Alignment.centerRight,
                  child: Loading(
                    size: SizeUtils.getSize(context, buttonVerticalPadding+SizeUtils.getSize(context, 4.sp)),
                  )
              );
            }
          )
        ],
      ),
    );
  }
}
