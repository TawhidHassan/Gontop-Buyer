// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'Chats.g.dart';

@JsonSerializable()
class Chats{

  @JsonKey(name: "_id")
  String? id;
  String? content;
  User? sender;
  String? createdAt;


  Chats(this.id, this.content, this.sender, this.createdAt);

  factory Chats.fromJson(Map<String,dynamic>json)=>
      _$ChatsFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatsToJson(this);
}