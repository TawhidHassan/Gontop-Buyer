// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Chat/ChatId.dart';
import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'ChatIdResponse.g.dart';

@JsonSerializable()
class ChatIdResponse{


  String? message;
  ChatId? chat;



  ChatIdResponse(this.message, this.chat);

  factory ChatIdResponse.fromJson(Map<String,dynamic>json)=>
      _$ChatIdResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatIdResponseToJson(this);
}