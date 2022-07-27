// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Chat/Chats.dart';
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'ChatsResponse.g.dart';

@JsonSerializable()
class ChatsResponse{


  String? status;

  List<Chats>? messages;


  ChatsResponse(this.status, this.messages);

  factory ChatsResponse.fromJson(Map<String,dynamic>json)=>
      _$ChatsResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatsResponseToJson(this);
}