
import 'dart:io';

import 'package:logger/logger.dart';

import '../../Data/Model/Login/Login.dart';
import '../../Network/LoginNetworkService/login_network.dart';

class LoginRepository{
  var logger = Logger();
  LoginNetwork loginNetwork=LoginNetwork();
  Future<Login> logIn(String email, String password) async {
    Map<String, String> data = {
      "id":email,
      "password": password,
    };
    final userRaw=await loginNetwork.logIn(data);
    logger.d(Login.fromJson(userRaw));

    return Login.fromJson(userRaw);
  }

  Future<Login> signUp(String name, String email, String phone, String password, File? image)async {

    final userRaw=await loginNetwork.signUp(name,email,phone,password,image);
    logger.d(Login.fromJson(userRaw));

    return Login.fromJson(userRaw);
  }


  Future<Login> passWordChange(String cureent, String newpass, String confirm, String token) async {
    Map<String, String> data = {
      "passwordCurrent": cureent,
      "password": newpass,
      "passwordConfirm": confirm
    };
    final userRaw=await loginNetwork.passWordChange(data,token);
    logger.d(Login.fromJson(userRaw));

    return Login.fromJson(userRaw);
  }

  Future updateProfile(String token,String name, String email, String phone, String password, File? image, String id) async {
    final userRaw=await loginNetwork.updateProfile(token,name,email,phone,password,image,id);
    // logger.d(Login.fromJson(userRaw));

    return Login.fromJson(userRaw);
  }


}