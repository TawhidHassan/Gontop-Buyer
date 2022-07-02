
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class UserNetwork{
  var logger = Logger();
  Future getAlluser(String? token,String? role) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "users/?limit=&pageNo=&role="+role!),
        headers: {
          "Authorization":"Bearer "+token!,
          "Accept": "application/json"
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }

  }

  Future createSeller(String? token, String name, String email, String phone, String password, File? image) async{
    try{
      var request =  http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+"users"),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+token!,
      };
      //add headers
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['role'] = "SELLER";
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
