// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'ChatId.g.dart';

@JsonSerializable()
class ChatId{

  @JsonKey(name: "_id")
  String? id;
  String? createdAt;


  ChatId(this.id, this.createdAt);



  factory ChatId.fromJson(Map<String,dynamic>json)=>
      _$ChatIdFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatIdToJson(this);
}