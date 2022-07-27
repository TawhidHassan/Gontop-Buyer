
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class ChatNetwork{
  var logger = Logger();


  Future createCategory(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "category"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
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

  Future getCategorieById(String? token,String? id) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "category?limit=&pageNo=&gameId="+id!),
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


  Future getChatId(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "chat-router"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getChats(String? token, String? id) async {
    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "chat-router/get-message/"+id!),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future sendMessage(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "chat-router/send-message"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future  sendMessageImage(String? token, String? chatId, String path) async {
    Logger().e(path);
    try{
      var request =  http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+"chat-router/send-message"),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+token!,
      };
      //add headers
      request.headers.addAll(headers);
      request.fields['chatId'] = chatId!;
      request.files.add(await http.MultipartFile.fromPath('image', path));
      request.fields['content'] = "";
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
