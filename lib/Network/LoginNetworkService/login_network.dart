
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class LoginNetwork{
  var logger = Logger();

 Future logIn(Map<String, String> data)async {
   // print("call");
   // print(data);
    try{
      var response = await http.post(
        Uri.parse(BASE_URL+"users/login"),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }
  }




  Future otpVerify(String? token,Map<String, dynamic> data) async{
    print(token);
    logger.d(json.encode(data));
    try{
      var response = await http.post(
        Uri.parse(BASE_URL + "question/verify_otp"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );

      logger.d(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }
  }


  Future otpResend(String? token,Map<String, dynamic> data) async{
    print(token);
    logger.d(json.encode(data));
    try{
      var response = await http.post(
        Uri.parse(BASE_URL + "question/resend_otp"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );

      logger.d(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }
  }

  Future signUp(String name, String email, String phone, String password, File? image) async {
    // print("call");
    // print(data);
    try{
      var request =  http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+"users/signup"),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      //add headers
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['role'] = "BUYER";
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
      request.fields['phoneNumber'] = phone;
      request.fields['password'] = password;
      request.fields['passwordConfirm'] = password;
      // logger.d(image.path);
      var streamedResponse =await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      logger.d(response.body);
      return json.decode(response.body);
    }catch(e){
      logger.d(e);
      return null;
    }
  }
}