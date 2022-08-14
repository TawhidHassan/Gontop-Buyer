
import 'dart:io';
import 'package:logger/logger.dart';

import '../../Data/Model/Login/Login.dart';
import '../../Data/Model/Product/ProductResponse.dart';
import '../../Network/GameNetworkService/game_network.dart';
import '../../Network/LoginNetworkService/login_network.dart';
import '../../Network/ProductNetworkService/product_network.dart';

class ProductRepository{
  var logger = Logger();
  ProductNetwork productNetwork=ProductNetwork();

  Future  createProduct(String? token, String name, String point, String price, String? id, String? categoryId, File? image) async{
    final userRaw=await productNetwork.createProduct(token,name,point,price,id,categoryId,image);
    // logger.d(Login.fromJson(userRaw));

    return userRaw;
  }

  Future<ProductResponse> getAllProduct(String? token) async{
    final userRaw=await productNetwork.getAllProduct(token);
    // logger.d(Login.fromJson(userRaw));

    return ProductResponse.fromJson(userRaw);
  }

  Future assignProduct(String? token, String? id, String? userId) async{
    Map<String, dynamic> data = {
      "product": id,
      "seller": userId,
    };
    final userRaw=await productNetwork.assignProduct(token,data);
    // logger.d(Login.fromJson(userRaw));

    return userRaw;
  }


  Future<ProductResponse> getAllProductsGame(String? token, String? id) async{
    final userRaw=await productNetwork.getAllProductsGame(token,id);
    // logger.d(Login.fromJson(userRaw));

    return ProductResponse.fromJson(userRaw);
  }
  Future<ProductResponse>  getAllProductsCategory(String? token, String? id) async{
    final userRaw=await productNetwork.getAllProductsCategory(token,id);
    // logger.d(Login.fromJson(userRaw));

    return ProductResponse.fromJson(userRaw);
  }




}