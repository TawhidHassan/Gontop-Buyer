
import 'dart:io';
import 'package:gontop_buyer/Network/ChatNetworkService/chat_network.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/Catgory/CategoryResponse.dart';
import '../../Data/Model/Chat/ChatIdResponse.dart';
import '../../Data/Model/Chat/ChatsResponse.dart';

class ChatRepository{
  var logger = Logger();
  ChatNetwork chatNetwork=ChatNetwork();

  Future createCategory(String? token, String name,String? id) async{
    Map<String, dynamic> data = {
      "categoryName": name,
      "gameId": id,
    };
    final userRaw=await chatNetwork.createCategory(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

  Future<CategoryResponse> getCategorys(String? token) async{
    final userRaw=await chatNetwork.getCategorys(token);
    // logger.d(Login.fromJson(userRaw));

    return CategoryResponse.fromJson(userRaw);
  }


  Future<CategoryResponse> getCategorieById(String? token,String? id) async{
    final userRaw=await chatNetwork.getCategorieById(token,id);
    // logger.d(Login.fromJson(userRaw));

    return CategoryResponse.fromJson(userRaw);
  }

  Future<ChatIdResponse> getChatId(String? token, String? userid) async{
    Map<String, dynamic> data = {
      "userId": userid,
    };
    final userRaw=await chatNetwork.getChatId(token,data);
    // logger.d(Login.fromJson(userRaw));

    return ChatIdResponse.fromJson(userRaw);
  }

 Future<ChatsResponse> getChats(String? token, String? id) async{
   final userRaw=await chatNetwork.getChats(token,id);
   // logger.d(Login.fromJson(userRaw));

   return ChatsResponse.fromJson(userRaw);
 }

  Future sendMessage(String? token, String? chatId, String text) async{
    Map<String, dynamic> data = {
      "chatId": chatId,
      "content":text,
      "messagetype":"text"
    };
    final userRaw=await chatNetwork.sendMessage(token,data);
    // logger.d(Login.fromJson(userRaw));

    return userRaw;
  }

  Future sendMessageImage(String? token, String? chatId, String path) async{
    final userRaw=await chatNetwork.sendMessageImage(token,chatId,path);
    // logger.d(Login.fromJson(userRaw));

    return userRaw;
  }


}