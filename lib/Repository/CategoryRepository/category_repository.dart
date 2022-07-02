
import 'dart:io';
import 'package:logger/logger.dart';

import '../../Data/Model/Catgory/CategoryResponse.dart';
import '../../Data/Model/Login/Login.dart';
import '../../Network/CategoryNetworkService/category_network.dart';
import '../../Network/GameNetworkService/game_network.dart';
import '../../Network/LoginNetworkService/login_network.dart';

class CategoryRepository{
  var logger = Logger();
  CategoryNetwork categoryNetwork=CategoryNetwork();

  Future createCategory(String? token, String name,String? id) async{
    Map<String, dynamic> data = {
      "categoryName": name,
      "gameId": id,
    };
    final userRaw=await categoryNetwork.createCategory(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

  Future<CategoryResponse> getCategorys(String? token) async{
    final userRaw=await categoryNetwork.getCategorys(token);
    // logger.d(Login.fromJson(userRaw));

    return CategoryResponse.fromJson(userRaw);
  }


  Future<CategoryResponse> getCategorieById(String? token,String? id) async{
    final userRaw=await categoryNetwork.getCategorieById(token,id);
    // logger.d(Login.fromJson(userRaw));

    return CategoryResponse.fromJson(userRaw);
  }


}