// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Chat/Chats.dart';
import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'ChatUser.g.dart';

@JsonSerializable()
class ChatUser{


  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? email;
  String? role;
  String? image;
  String? phoneNumber;
  String? friendid;
  bool? online;
  Chats? chats;


  ChatUser(this.id, this.name, this.email, this.role, this.image,
      this.phoneNumber, this.friendid, this.online, this.chats);

  factory ChatUser.fromJson(Map<String,dynamic>json)=>
      _$ChatUserFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatUserToJson(this);
}