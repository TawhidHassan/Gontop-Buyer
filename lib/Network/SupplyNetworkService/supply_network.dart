
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class SupplyNetwork{
  var logger = Logger();






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


  Future getAllSellerMainLogs(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "supply-router/?pageNo=&limit="),
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



  Future createGivenSupply(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "supply-router/"),
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

  Future getFullPAymentLog(String? token, String? userId) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "supply-router/supply-log?pageNo=0&limit=0&sellerId="+userId!),
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
  Future getAdminTotalSupplyValue(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "supply-router/supply-taken-given-value"),
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
