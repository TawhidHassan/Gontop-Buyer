
import 'dart:io';

import 'package:gontop_buyer/Data/Model/Chat/ChatUsers/ChatUserResponse.dart';
import 'package:gontop_buyer/Data/Model/Friend/FriendsList.dart';
import 'package:gontop_buyer/Data/Model/Friend/RequestedUserResponse.dart';
import 'package:gontop_buyer/Data/Model/RandomUser/RandomUserResponse.dart';
import 'package:logger/logger.dart';

import '../../Data/LeaderBorad/LeaderBoardResponse.dart';
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

 Future addRequest(String? token, String? id) async{
    Map<String, dynamic> data = {
      "friend": id,

    };
    final userRaw=await userNetwork.addRequest(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

  Future<RequestedUserResponse> getAllRequstedUser(String? token) async{
    final userRaw=await userNetwork.getAllRequstedUser(token);
    // logger.d(Login.fromJson(userRaw));

    return RequestedUserResponse.fromJson(userRaw);
  }


  Future acceptFriendRequest(String? token, String? id, String status) async{
    Map<String, dynamic> data = {
      "request":status
    };
    final userRaw=await userNetwork.acceptFriendRequest(token,data,id);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

  Future<FriendsList> getAllFriends(String? token) async{
    final userRaw=await userNetwork.getAllFriends(token);
    // logger.d(Login.fromJson(userRaw));

    return FriendsList.fromJson(userRaw);
  }

  Future unfriend(String? token, String? id) async{
    Map<String, dynamic> data = {
      "friend": id
    };
    final userRaw=await userNetwork.unfriend(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

  Future<ChatUserResponse> getAllUserChat(String? token) async{
    final userRaw=await userNetwork.getAllUserChat(token);
    // logger.d(Login.fromJson(userRaw));

    return ChatUserResponse.fromJson(userRaw);
  }
  Future<LeaderBoardResponse> getLeaderBoard(String? token) async{
    final userRaw=await userNetwork.getLeaderBoard(token);
    // logger.d(Login.fromJson(userRaw));

    return LeaderBoardResponse.fromJson(userRaw);
  }



}