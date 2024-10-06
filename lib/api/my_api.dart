import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class MyApi{

  static const coinMarketCapKey="ac393758-07e2-4c34-8134-cb1bec7d9ea8";
  static const bscScanKey="44F2IJ8EJQT5JAWUIFWRH96SKIGSNWXJZB";



  Future<http.Response?> post(var body,String urlLocation,var headers)async{
    try{
      var url = Uri.parse(urlLocation);
      log(url.toString());
      log(body.toString());
      var response = await http.post(url, body: body,headers: headers);
      log(response.statusCode.toString());
      return response;
    }catch(e){
      log(e.toString());
    }
  }
  Future<http.Response?> get(String urlLocation,var headers)async{
    try{
      var url = Uri.parse(urlLocation);
      log(url.toString());
      var response = await http.get(url,headers: headers);
      return response;
    }catch(e){
      log(e.toString());
    }
  }

  Future<Stream<http.StreamedResponse>> streamPost(String location,dynamic body,var headers)async{
    var url = Uri.parse(location);
    http.BaseRequest request = Request('POST',url);
    try{
      request.headers.addAll(headers);
      final Stream<http.StreamedResponse> response =Client().send(request).asStream();
      return response;
    }catch(e){
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<Stream<http.StreamedResponse>> streamGet(String location,var headers)async{
    var url = Uri.parse(location);
    http.BaseRequest request = Request('GET',url);
    try{
      request.headers.addAll(headers);
      final Stream<http.StreamedResponse> response =Client().send(request).asStream();
      return response;
    }catch(e){
      log(e.toString());
      throw Exception(e);
    }
  }
}