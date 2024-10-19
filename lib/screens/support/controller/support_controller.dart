import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bunker/screens/support/model/TicketMessage.dart';
import 'package:bunker/screens/support/model/support_ticket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';

class SupportController extends ChangeNotifier{
  final my_api = MyApi();
  Dio dio = Dio();
  List<SupportTicket> supportTickets=[];
  List<SupportTicket> adminSupportTickets=[];
  Map<String,List<TicketMessage>> ticketMessages={};
  Map<String,List<TicketMessage>> adminTicketMessages={};
  bool supportTicketLoading=true;
  bool adminSupportTicketLoading=true;


  Future<void> createTicket({required UserCredential credential,required SupportTicket supportTicket})async{
    log("Creating ticket");
    try{
      var body= {
        "subject": supportTicket.subject,
        "message": supportTicket.message
      };
      var response = await my_api.post(jsonEncode(body),ApiUrls.createSupportTicket, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Creating ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final ticket=SupportTicket.fromJson(jsonDecode(response.body));
        supportTickets.add(ticket);
      }else{
        throw Exception();
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      throw Exception("Unable to get add payment method");
    }
  }

  Future<void> getUserTickets({required UserCredential credential})async{
    log("Getting user support ticket");
    supportTicketLoading=true;
    notifyListeners();
    try{
      var response = await my_api.get(ApiUrls.userTickets, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("User Support ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        supportTickets=supportTicketFromJson(response.body);
      }
      supportTicketLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get user tickets");
    }
  }


  Future<void> getAllTickets({required UserCredential credential})async{
    log("Getting support ticket");
    adminSupportTicketLoading=true;
    notifyListeners();
    try{
      var response = await my_api.get(ApiUrls.supportTickets, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Support ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        adminSupportTickets=supportTicketFromJson(response.body);
      }
      adminSupportTicketLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get tickets");
    }
  }

  Future<void> loadTicketMessage({required UserCredential credential,required String ticketId})async{
    log("Getting ticket message: $ticketId");
    try {
      List<TicketMessage> messages=[];
      var response = await dio.get(ApiUrls.getTicketMessage,
        queryParameters: {'ticketId': ticketId},
        options: Options(
          headers: {"Authorization":"Bearer ${credential.token}"},
          contentType: "application/octet-stream",
          persistentConnection: true,
          responseType: ResponseType.stream, // This is crucial for streaming
        ),
      );

      // Stream handling
      response.data.stream.listen((List<int> value) {
        // Decode each chunk of data received
        if(value.length>1){
          var decoded=utf8.decode(value);
          List<String> decodedList=decoded.split("\n");
          decodedList.map((e){
          log("Message: $e");
          if(e.isEmpty){
            return;
          }
          TicketMessage m=ticketMessageFromJson(e);
          if(messages.where((element) => element.id==m.id).isEmpty){
            messages.add(m);
            ticketMessages[ticketId]=messages;
            notifyListeners();
          }
          }).toList();
        }

      }, onError: (error) {
        log(error.toString());
        throw Exception("Unable to get ticket message");
      }, onDone: () {
        log("Stream finished.");
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  //Load ticket message for admin
  Future<void> loadTicketMessageForAdmin({required UserCredential credential,required String ticketId})async{
    log("Getting ticket message: $ticketId");
    try {
      List<TicketMessage> messages=[];
      var response = await dio.get(ApiUrls.getTicketMessage,
        queryParameters: {'ticketId': ticketId},
        options: Options(
          headers: {"Authorization":"Bearer ${credential.token}"},
          contentType: "application/octet-stream",
          persistentConnection: true,
          responseType: ResponseType.stream, // This is crucial for streaming
        ),
      );

      // Stream handling
      response.data.stream.listen((List<int> value) {
        // Decode each chunk of data received
        if(value.length>1){
          var decoded=utf8.decode(value);
          List<String> decodedList=decoded.split("\n");
          decodedList.map((e){
          log("Message: $e");
          if(e.isEmpty){
            return;
          }
          TicketMessage m=ticketMessageFromJson(e);
          if(messages.where((element) => element.id==m.id).isEmpty){
            messages.add(m);
            adminTicketMessages[ticketId]=messages;
            notifyListeners();
          }
          }).toList();
        }

      }, onError: (error) {
        log(error.toString());
        throw Exception("Unable to get ticket message");
      }, onDone: () {
        log("Stream finished.");
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  //This function is used by the user to send a message to a ticket
  Future<void> sendMessage({required UserCredential credential,required String ticketId,required String message,required String imageUrl, required bool isMedia})async{
    log("Sending message");
    try{
      var body= {
        "ticket_id":ticketId,
        "message":message,
        "is_media":isMedia,
        "image_url":imageUrl
      };
      var response = await my_api.post(jsonEncode(body),ApiUrls.sendMessage, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Send message: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final message=TicketMessage.fromJson(jsonDecode(response.body));
        if(ticketMessages.containsKey(ticketId)){
          ticketMessages[ticketId]!.add(message);
          notifyListeners();
        }
      }else{
        throw Exception();
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      throw Exception("Unable to send message");
    }
  }

  //This function is used by the admin to reply to a ticket
  Future<void> addReply({required UserCredential credential,required String ticketId,required int receiverUid,required String message,required String imageUrl, required bool isMedia})async{
    log("Sending message");
    try{
      var body= {
        "ticket_id":ticketId,
        "receiver_uid":receiverUid,
        "message":message,
        "is_media":isMedia,
        "image_url":imageUrl
      };
      var response = await my_api.post(jsonEncode(body),ApiUrls.sendMessage, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Send message: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final message=TicketMessage.fromJson(jsonDecode(response.body));
        if(ticketMessages.containsKey(ticketId)){
          adminTicketMessages[ticketId]!.add(message);
          notifyListeners();
        }
      }else{
        throw Exception();
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      throw Exception("Unable to send message");
    }
  }

  Future<String> uploadImage({required UserCredential credential,required Uint8List bytes})async{
    log("Uploading image");
    try{
      var response = await my_api.singleMultipartRequest(ApiUrls.uploadImage,bytes, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Uploading image: Response code ${response.statusCode}");
      if (response.statusCode == 200) {
        String imageUrl = response.data["url"];
        log("Image URL: $imageUrl");
        return imageUrl;
      } else {
        log("Error uploading image: ${response.statusCode}");
        throw Exception("Failed to upload image. Status code: ${response.statusCode}");
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      throw Exception("Unable to send message");
    }
  }
}