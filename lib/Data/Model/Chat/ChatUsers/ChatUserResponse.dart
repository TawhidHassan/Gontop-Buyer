// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Chat/ChatUsers/ChatUser.dart';
import 'package:json_annotation/json_annotation.dart';


part 'ChatUserResponse.g.dart';

@JsonSerializable()
class ChatUserResponse{


  String? status;
  List<ChatUser>? user;


  ChatUserResponse(this.status, this.user);

  factory ChatUserResponse.fromJson(Map<String,dynamic>json)=>
      _$ChatUserResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatUserResponseToJson(this);
}