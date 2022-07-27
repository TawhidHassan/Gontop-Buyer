// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'ChatId.g.dart';

@JsonSerializable()
class ChatId{

  @JsonKey(name: "_id")
  String? id;
  String? createdAt;
  List<User>? users;


  ChatId(this.id, this.createdAt, this.users);

  factory ChatId.fromJson(Map<String,dynamic>json)=>
      _$ChatIdFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatIdToJson(this);
}