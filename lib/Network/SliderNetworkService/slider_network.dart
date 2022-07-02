
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class SliderNetwork{
  var logger = Logger();

  Future createSlider(String? token, String name, File? image) async{
    try{
      var request =  http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+"ads"),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+token!,
      };
      //add headers
      request.headers.addAll(headers);
      request.fields['adsName'] = name;
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
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

  Future getCategorys(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "category?limit=&pageNo="),
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

  Future getAllSliders(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "ads?limit=&pageNo="),
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






}
