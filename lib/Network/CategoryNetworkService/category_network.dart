
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class CategoryNetwork{
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

  Future getAllAnnouncement(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "announcement"),
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




  Future createAnnouncement(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "announcement"),
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

  Future deleteAnnouncement(String? token,String? id) async {
    try {
      var response = await http.delete(
        Uri.parse(BASE_URL + "announcement/"+id!),
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

  Future incrementLike(String? token,String? id) async {
    try {
      var response = await http.patch(
        Uri.parse(BASE_URL + "announcement/"+id!+"?value=increment"),
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


}
