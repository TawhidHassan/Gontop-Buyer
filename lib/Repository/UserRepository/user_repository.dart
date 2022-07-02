
import 'dart:io';

import 'package:gontop_buyer/Data/Model/RandomUser/RandomUserResponse.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/Login/Login.dart';
import '../../Data/Model/User/UserResponse.dart';
import '../../Network/GameNetworkService/game_network.dart';
import '../../Network/LoginNetworkService/login_network.dart';
import '../../Network/UserNetworkService/user_network.dart';

class UserRepository{
  var logger = Logger();
  UserNetwork userNetwork=UserNetwork();


  Future<UserResponse> getAlluser(String? token,String? role) async{
    final userRaw=await userNetwork.getAlluser(token,role);
    // logger.d(Login.fromJson(userRaw));

    return UserResponse.fromJson(userRaw);
  }

  Future createSeller(String? token, String name, String email, String phone, String password, File? image) async{
    final userRaw=await userNetwork.createSeller(token, name,email,phone,password,image);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }


  Future<RandomUserResponse> getRandomUser(String? token) async{
    final userRaw=await userNetwork.getRandomUser(token);
    // logger.d(Login.fromJson(userRaw));

    return RandomUserResponse.fromJson(userRaw);
  }

}