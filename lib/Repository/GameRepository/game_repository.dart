
import 'dart:io';
import 'package:logger/logger.dart';

import '../../Data/Model/Game/GameResponse.dart';
import '../../Data/Model/Login/Login.dart';
import '../../Network/GameNetworkService/game_network.dart';
import '../../Network/LoginNetworkService/login_network.dart';

class GameRepository{
  var logger = Logger();
  GameNetwork gameNetwork=GameNetwork();

  Future createGame(String? token, String name,String about, File? image) async{
    final userRaw=await gameNetwork.createGame(token,name,about,image);
    // logger.d(Login.fromJson(userRaw));

    return userRaw;
  }

  Future<GameResponse> getGames(String? token) async{
    final userRaw=await gameNetwork.getGames(token);
    // logger.d(Login.fromJson(userRaw));

    return GameResponse.fromJson(userRaw);
  }



}