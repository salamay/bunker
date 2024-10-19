import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class MyApi{

  static const coinMarketCapKey="ac393758-07e2-4c34-8134-cb1bec7d9ea8";
  static const bscScanKey="44F2IJ8EJQT5JAWUIFWRH96SKIGSNWXJZB";
  Dio dio = Dio();



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
    http.BaseRequest request = http.Request('POST',url);
    try{
      request.headers.addAll(headers);
      final Stream<http.StreamedResponse> response =http.Client().send(request).asStream();
      return response;
    }catch(e){
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<http.StreamedResponse> streamGet(String url, Map<String, String> headers) async {
    var client = http.Client();
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    // Send the request as a stream
    return client.send(request);
  }
  Future<Response> singleMultipartRequest(String urlLocation,Uint8List fromBytes,var headers)async{
    // Create a FormData object to hold the file and any other data
    FormData formData = FormData.fromMap({
      "file":  MultipartFile.fromBytes(fromBytes, filename: "file.png"),
    });
    // Make the request
    Response response = await dio.post(
      urlLocation,
      data: formData,
      options: Options(
        headers: headers
      ),
    );
    return response;
  }
  // Future<http.StreamedResponse?> multipleMultipartRequest(String urlLocation,Map<dynamic,File> files,var headers)async{
  //   var request=http.MultipartRequest("POST", Uri.parse(urlLocation));
  //   request.headers.addAll(headers);
  //   for(var k in files.keys){
  //     request.files.add(await http.MultipartFile.fromPath(k, files[k]!.path));
  //   }
  //   var response =await request.send();
  //   return response;
  // }
}